"""
安全模块 - 封装加密、哈希、JWT 等安全功能
复用 Core.py 中的 Argon2 + AES(Fernet) + HMAC 算法
"""
import base64
import hashlib
import hmac as hmac_module
import secrets
import json
import copy
from datetime import datetime, timedelta, timezone
from typing import Optional

from argon2 import PasswordHasher, Type
from argon2.exceptions import VerifyMismatchError
from cryptography.fernet import Fernet
from jose import JWTError, jwt

from app.core.config import get_settings


class SecurityService:
    """安全服务：统一管理加密、哈希、Token 功能"""

    def __init__(self):
        settings = get_settings()
        self.ph = PasswordHasher(
            type=Type.ID,
            memory_cost=settings.ARGON2_MEMORY_COST,
            time_cost=settings.ARGON2_TIME_COST,
            parallelism=settings.ARGON2_PARALLELISM,
            hash_len=settings.ARGON2_HASH_LEN,
        )
        self.jwt_secret = settings.JWT_SECRET_KEY
        self.jwt_algorithm = settings.JWT_ALGORITHM
        self.access_token_expire = settings.ACCESS_TOKEN_EXPIRE_MINUTES
        self.refresh_token_expire = settings.REFRESH_TOKEN_EXPIRE_DAYS

    # ==================== 密码哈希 ====================

    def hash_password(self, password: str) -> str:
        """使用 Argon2id 对密码进行哈希"""
        return self.ph.hash(password)

    def verify_password(self, plain_password: str, hashed_password: str) -> bool:
        """验证密码是否匹配哈希"""
        try:
            self.ph.verify(hashed_password, plain_password)
            return True
        except VerifyMismatchError:
            return False

    # ==================== JWT Token ====================

    def create_access_token(self, data: dict) -> str:
        """创建访问令牌"""
        to_encode = data.copy()
        expire = datetime.now(timezone.utc) + timedelta(minutes=self.access_token_expire)
        to_encode.update({"exp": expire, "type": "access"})
        return jwt.encode(to_encode, self.jwt_secret, algorithm=self.jwt_algorithm)

    def create_refresh_token(self, data: dict) -> str:
        """创建刷新令牌"""
        to_encode = data.copy()
        expire = datetime.now(timezone.utc) + timedelta(days=self.refresh_token_expire)
        to_encode.update({"exp": expire, "type": "refresh"})
        return jwt.encode(to_encode, self.jwt_secret, algorithm=self.jwt_algorithm)

    def decode_token(self, token: str) -> Optional[dict]:
        """解码并验证 JWT Token"""
        try:
            payload = jwt.decode(token, self.jwt_secret, algorithms=[self.jwt_algorithm])
            return payload
        except JWTError:
            return None

    # ==================== AES 加密 ====================

    def generate_encryption_salt(self) -> bytes:
        """生成 AES 加密盐"""
        return secrets.token_bytes(16)

    def generate_hmac_salt(self) -> bytes:
        """生成 HMAC 盐"""
        return secrets.token_bytes(32)

    def derive_aes_key(self, master_key: str, salt: bytes) -> bytes:
        """使用 Argon2 从主密码派生 AES-256 密钥"""
        hash_result = self.ph.hash(master_key, salt=salt)
        hash_bytes = self._argon2_base64_decode(hash_result.split("$")[-1])
        aes_key = hash_bytes[:32]
        if len(aes_key) < 32:
            raise ValueError("哈希结果长度不足，无法生成32字节AES密钥")
        return aes_key

    def derive_hmac_key(self, master_key: str, salt: bytes) -> bytes:
        """使用 Argon2 从主密码派生 HMAC 密钥"""
        hash_result = self.ph.hash(master_key, salt=salt)
        hash_bytes = self._argon2_base64_decode(hash_result.split("$")[-1])
        hmac_key = hash_bytes[:16]
        if len(hmac_key) < 16:
            raise ValueError("哈希结果长度不足，无法生成16字节HMAC密钥")
        return hmac_key

    def encrypt_aes(self, plaintext: str, aes_key: bytes) -> str:
        """使用 AES(Fernet) 加密明文"""
        fernet_key = base64.urlsafe_b64encode(aes_key)
        if len(fernet_key) != 44:
            raise ValueError(f"无效的Fernet密钥长度: {len(fernet_key)}")
        fernet = Fernet(fernet_key)
        return fernet.encrypt(plaintext.encode("utf-8")).decode("utf-8")

    def decrypt_aes(self, ciphertext: str, aes_key: bytes) -> str:
        """使用 AES(Fernet) 解密密文"""
        fernet_key = base64.urlsafe_b64encode(aes_key)
        fernet = Fernet(fernet_key)
        return fernet.decrypt(ciphertext.encode("utf-8")).decode("utf-8")

    # ==================== HMAC 完整性 ====================

    def compute_hmac(self, data: dict, hmac_key: bytes) -> str:
        """计算数据的 HMAC-SHA256 值"""
        data_to_check = copy.deepcopy(data)
        data_str = json.dumps(
            data_to_check, sort_keys=True, ensure_ascii=False, separators=(",", ":")
        ).encode()
        return hmac_module.new(hmac_key, msg=data_str, digestmod=hashlib.sha256).hexdigest()

    def verify_hmac(self, data: dict, hmac_key: bytes, expected: str) -> bool:
        """验证 HMAC"""
        return hmac_module.compare_digest(self.compute_hmac(data, hmac_key), expected)

    # ==================== 密码强度评估 ====================

    @staticmethod
    def get_password_level(password: str) -> int:
        """评估密码强度（0-5级）"""
        import re
        if not isinstance(password, str) or len(password) == 0:
            return 0
        score = 0
        length = len(password)
        if length >= 16:
            score += 3
        elif length >= 12:
            score += 2
        elif length >= 8:
            score += 1
        has_lower = re.search(r"[a-z]", password) is not None
        has_upper = re.search(r"[A-Z]", password) is not None
        has_digit = re.search(r"\d", password) is not None
        has_special = re.search(r"[^a-zA-Z0-9]", password) is not None
        score += sum([has_lower, has_upper, has_digit, has_special])
        if not (password.isdigit() or password.isalpha()):
            score += 1
        weak_patterns = [r"^(0-9){6,}$", r"^[a-zA-Z]{6,}$", r"^(.)\1{4,}$", r"^123456|654321|111111|abcdef|fedcba$"]
        if not any(re.match(p, password.lower()) for p in weak_patterns):
            score += 1
        common_words = {"password", "123456", "qwerty", "admin", "user", "passwd", "abc123"}
        if password.lower() not in common_words and not any(w in password.lower() for w in common_words):
            score += 1
        return min(5, max(0, score // 2))

    # ==================== 工具方法 ====================

    @staticmethod
    def _argon2_base64_decode(encoded: str) -> bytes:
        """解码 Argon2 使用的 Base64 变体"""
        encoded = encoded.replace("-", "+").replace("_", "/")
        padding_needed = (4 - (len(encoded) % 4)) % 4
        encoded += "=" * padding_needed
        return base64.b64decode(encoded)

    @staticmethod
    def is_base64(s: str) -> bool:
        """验证字符串是否为 Base64 编码"""
        try:
            return base64.b64encode(base64.b64decode(s)) == s.encode()
        except Exception:
            return False


# 全局单例
security_service = SecurityService()
