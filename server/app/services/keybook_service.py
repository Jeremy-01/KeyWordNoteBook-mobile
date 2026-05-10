"""
密码本服务 - 处理密码条目的增删改查
"""
import base64
import json
from sqlalchemy.orm import Session

from app.core.security import security_service
from app.models.keybook import KeyBookMeta, KeyItem
from app.schemas.keybook import KeyItemCreate, KeyItemUpdate


class KeyBookService:
    """密码本服务"""

    def _get_keybook(self, db: Session, user_id: str) -> KeyBookMeta:
        """获取用户的密码本元数据"""
        kb = db.query(KeyBookMeta).filter(KeyBookMeta.user_id == user_id).first()
        if not kb:
            raise ValueError("密码本不存在，请先注册")
        return kb

    def _derive_keys(self, master_password: str, kb: KeyBookMeta) -> tuple:
        """从主密码派生 AES 和 HMAC 密钥"""
        encryption_salt = base64.b64decode(kb.encryption_salt)
        hmac_salt = base64.b64decode(kb.hmac_salt)

        aes_key = security_service.derive_aes_key(master_password, encryption_salt)

        # 解密 HMAC 密钥
        hmac_key_b64 = security_service.decrypt_aes(kb.hmac_key_encrypted, aes_key)
        hmac_key = base64.b64decode(hmac_key_b64)

        return aes_key, hmac_key

    def _verify_master_password(self, master_password: str, kb: KeyBookMeta) -> bool:
        """验证主密码"""
        return security_service.verify_password(master_password, kb.verify_hash)

    def _get_next_index(self, db: Session, keybook_id: int) -> str:
        """获取下一个条目序号"""
        items = db.query(KeyItem).filter(KeyItem.keybook_id == keybook_id).all()
        if not items:
            return "1"
        max_idx = max(int(item.item_index) for item in items)
        return str(max_idx + 1)

    def get_items(self, db: Session, user_id: str, page: int = 1, page_size: int = 20) -> dict:
        """获取密码条目列表（非敏感字段）"""
        kb = self._get_keybook(db, user_id)
        query = db.query(KeyItem).filter(KeyItem.keybook_id == kb.id).order_by(KeyItem.item_index)
        total = query.count()
        items = query.offset((page - 1) * page_size).limit(page_size).all()

        return {
            "items": [
                {
                    "index": item.item_index,
                    "url": item.url,
                    "username": item.username,
                    "password_level": item.password_level,
                    "link_url": item.link_url,
                    "note": item.note,
                }
                for item in items
            ],
            "total": total,
            "page": page,
            "page_size": page_size,
        }

    def get_item_detail(self, db: Session, user_id: str, item_index: str, master_password: str) -> dict:
        """获取单个条目详情（含解密密码）"""
        kb = self._get_keybook(db, user_id)
        if not self._verify_master_password(master_password, kb):
            raise ValueError("主密码验证失败")

        item = db.query(KeyItem).filter(
            KeyItem.keybook_id == kb.id,
            KeyItem.item_index == item_index,
        ).first()
        if not item:
            raise ValueError("条目不存在")

        aes_key, _ = self._derive_keys(master_password, kb)
        decrypted_password = security_service.decrypt_aes(item.password_encrypted, aes_key)

        return {
            "index": item.item_index,
            "url": item.url,
            "username": item.username,
            "password": decrypted_password,
            "password_level": item.password_level,
            "link_url": item.link_url,
            "note": item.note,
        }

    def add_item(self, db: Session, user_id: str, data: KeyItemCreate, master_password: str) -> str:
        """添加密码条目"""
        kb = self._get_keybook(db, user_id)
        if not self._verify_master_password(master_password, kb):
            raise ValueError("主密码验证失败")

        aes_key, _ = self._derive_keys(master_password, kb)
        item_index = self._get_next_index(db, kb.id)
        password_level = security_service.get_password_level(data.password)
        encrypted_password = security_service.encrypt_aes(data.password, aes_key)

        item = KeyItem(
            keybook_id=kb.id,
            item_index=item_index,
            url=data.url,
            username=data.username,
            password_encrypted=encrypted_password,
            password_level=password_level,
            link_url=data.link_url,
            note=data.note,
            version=kb.version,
        )
        db.add(item)

        # 更新密码本版本
        kb.version += 1
        db.commit()

        return item_index

    def update_item(self, db: Session, user_id: str, item_index: str, data: KeyItemUpdate, master_password: str) -> bool:
        """更新密码条目"""
        kb = self._get_keybook(db, user_id)
        if not self._verify_master_password(master_password, kb):
            raise ValueError("主密码验证失败")

        item = db.query(KeyItem).filter(
            KeyItem.keybook_id == kb.id,
            KeyItem.item_index == item_index,
        ).first()
        if not item:
            raise ValueError("条目不存在")

        aes_key, _ = self._derive_keys(master_password, kb)

        if data.url is not None:
            item.url = data.url
        if data.username is not None:
            item.username = data.username
        if data.password is not None:
            item.password_encrypted = security_service.encrypt_aes(data.password, aes_key)
            item.password_level = security_service.get_password_level(data.password)
        if data.link_url is not None:
            item.link_url = data.link_url
        if data.note is not None:
            item.note = data.note

        kb.version += 1
        db.commit()
        return True

    def delete_item(self, db: Session, user_id: str, item_index: str, master_password: str) -> bool:
        """删除密码条目"""
        kb = self._get_keybook(db, user_id)
        if not self._verify_master_password(master_password, kb):
            raise ValueError("主密码验证失败")

        item = db.query(KeyItem).filter(
            KeyBookMeta.user_id == user_id,
            KeyItem.keybook_id == kb.id,
            KeyItem.item_index == item_index,
        ).first()
        if not item:
            raise ValueError("条目不存在")

        db.delete(item)
        kb.version += 1
        db.commit()
        return True


keybook_service = KeyBookService()
