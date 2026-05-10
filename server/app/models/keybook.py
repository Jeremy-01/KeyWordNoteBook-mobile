"""
密码本相关模型
"""
from datetime import datetime
from sqlalchemy import String, Integer, Text, DateTime, ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.database import Base


class KeyBookMeta(Base):
    """密码本元数据（每个用户一个）"""
    __tablename__ = "keybook_meta"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    user_id: Mapped[str] = mapped_column(String(32), ForeignKey("users.id"), unique=True, nullable=False)
    version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    # 加密参数（JSON 字符串存储）
    verify_hash: Mapped[str] = mapped_column(Text, nullable=False)
    encryption_salt: Mapped[str] = mapped_column(Text, nullable=False)
    hmac_salt: Mapped[str] = mapped_column(Text, nullable=False)
    hmac_key_encrypted: Mapped[str] = mapped_column(Text, nullable=False)
    integrity_check: Mapped[str] = mapped_column(String(64), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), onupdate=func.now())

    # 关系
    user: Mapped["User"] = relationship("User", back_populates="keybook")
    items: Mapped[list["KeyItem"]] = relationship("KeyItem", back_populates="keybook", cascade="all, delete-orphan")
    sync_operations: Mapped[list["SyncOperation"]] = relationship("SyncOperation", back_populates="keybook", cascade="all, delete-orphan")


class KeyItem(Base):
    """密码条目"""
    __tablename__ = "key_items"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    keybook_id: Mapped[int] = mapped_column(Integer, ForeignKey("keybook_meta.id"), nullable=False)
    item_index: Mapped[str] = mapped_column(String(32), nullable=False)  # 条目序号
    url: Mapped[str] = mapped_column(Text, nullable=False)
    username: Mapped[str] = mapped_column(Text, nullable=False)
    password_encrypted: Mapped[str] = mapped_column(Text, nullable=False)  # AES 加密后的密码
    password_level: Mapped[int] = mapped_column(Integer, default=0)
    link_url: Mapped[str] = mapped_column(Text, default="")
    note: Mapped[str] = mapped_column(Text, default="")
    version: Mapped[int] = mapped_column(Integer, default=1)  # 条目版本号
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), onupdate=func.now())

    # 关系
    keybook: Mapped["KeyBookMeta"] = relationship("KeyBookMeta", back_populates="items")


class SyncOperation(Base):
    """同步操作记录"""
    __tablename__ = "sync_operations"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    keybook_id: Mapped[int] = mapped_column(Integer, ForeignKey("keybook_meta.id"), nullable=False)
    operation_type: Mapped[str] = mapped_column(String(20), nullable=False)  # create/update/delete
    item_index: Mapped[str | None] = mapped_column(String(32), nullable=True)
    operation_data: Mapped[str | None] = mapped_column(Text, nullable=True)  # JSON 字符串
    version: Mapped[int] = mapped_column(Integer, nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now())

    # 关系
    keybook: Mapped["KeyBookMeta"] = relationship("KeyBookMeta", back_populates="sync_operations")
