"""
认证服务 - 处理用户注册、登录、Token 管理
"""
import uuid
from datetime import datetime, timezone
from sqlalchemy.orm import Session

from app.core.security import security_service
from app.models.user import User
from app.models.keybook import KeyBookMeta
from app.schemas.auth import RegisterRequest, LoginRequest, TokenResponse, UserInfo


class AuthService:
    """认证服务"""

    def register(self, db: Session, req: RegisterRequest) -> dict:
        """用户注册"""
        # 验证两次密码一致
        if req.password != req.password_confirm:
            raise ValueError("两次输入的密码不一致")

        # 检查邮箱是否已注册
        existing = db.query(User).filter(User.email == req.email).first()
        if existing:
            raise ValueError("该邮箱已被注册")

        # 创建用户
        user_id = f"usr_{uuid.uuid4().hex[:12]}"
        user = User(
            id=user_id,
            email=req.email,
            password_hash=security_service.hash_password(req.password),
        )
        db.add(user)
        db.flush()

        # 为用户创建密码本元数据
        self._init_keybook(db, user_id, req.password)

        db.commit()
        db.refresh(user)

        return {
            "user_id": user_id,
            "email": user.email,
            "created_at": user.created_at.isoformat(),
        }

    def login(self, db: Session, req: LoginRequest) -> dict:
        """用户登录"""
        user = db.query(User).filter(User.email == req.email).first()
        if not user or not security_service.verify_password(req.password, user.password_hash):
            raise ValueError("邮箱或密码错误")

        if not user.is_active:
            raise ValueError("账号已被禁用")

        # 更新最后登录时间
        user.last_login_at = datetime.now(timezone.utc)
        db.commit()

        # 生成 Token
        token_data = {"sub": user.id}
        access_token = security_service.create_access_token(token_data)
        refresh_token = security_service.create_refresh_token(token_data)

        return {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "expires_in": 60 * 60,
            "token_type": "Bearer",
        }

    def refresh_token(self, db: Session, refresh_token: str) -> dict:
        """刷新访问令牌"""
        payload = security_service.decode_token(refresh_token)
        if not payload or payload.get("type") != "refresh":
            raise ValueError("无效的刷新令牌")

        user_id = payload.get("sub")
        user = db.query(User).filter(User.id == user_id).first()
        if not user or not user.is_active:
            raise ValueError("用户不存在或已被禁用")

        token_data = {"sub": user.id}
        new_access = security_service.create_access_token(token_data)

        return {
            "access_token": new_access,
            "expires_in": 60 * 60,
        }

    def get_user_info(self, db: Session, user_id: str) -> dict:
        """获取用户信息"""
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise ValueError("用户不存在")
        return {
            "user_id": user.id,
            "email": user.email,
            "created_at": user.created_at.isoformat(),
        }

    def _init_keybook(self, db: Session, user_id: str, master_password: str):
        """为新用户初始化密码本"""
        # 生成盐值
        encryption_salt = security_service.generate_encryption_salt()
        hmac_salt = security_service.generate_hmac_salt()

        # 派生密钥
        verify_hash = security_service.hash_password(master_password)
        aes_key = security_service.derive_aes_key(master_password, encryption_salt)
        hmac_key = security_service.derive_hmac_key(master_password, hmac_salt)

        # 加密存储 HMAC 密钥
        hmac_key_b64 = __import__("base64").b64encode(hmac_key).decode("utf-8")
        hmac_key_encrypted = security_service.encrypt_aes(hmac_key_b64, aes_key)

        # 盐值转 Base64 存储
        enc_salt_b64 = __import__("base64").b64encode(encryption_salt).decode("utf-8")
        hmac_salt_b64 = __import__("base64").b64encode(hmac_salt).decode("utf-8")

        keybook = KeyBookMeta(
            user_id=user_id,
            version=1,
            verify_hash=verify_hash,
            encryption_salt=enc_salt_b64,
            hmac_salt=hmac_salt_b64,
            hmac_key_encrypted=hmac_key_encrypted,
            integrity_check="0" * 64,  # 初始值，后续更新
        )
        db.add(keybook)


auth_service = AuthService()
