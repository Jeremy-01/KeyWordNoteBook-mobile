"""
同步服务 - 处理数据同步
"""
import json
from datetime import datetime, timezone
from sqlalchemy.orm import Session

from app.models.keybook import KeyBookMeta, SyncOperation


class SyncService:
    """同步服务"""

    def get_status(self, db: Session, user_id: str, client_version: int) -> dict:
        """获取同步状态"""
        kb = db.query(KeyBookMeta).filter(KeyBookMeta.user_id == user_id).first()
        if not kb:
            raise ValueError("密码本不存在")

        server_version = kb.version
        need_sync = client_version != server_version

        # 获取最后同步时间
        last_op = db.query(SyncOperation).filter(
            SyncOperation.keybook_id == kb.id
        ).order_by(SyncOperation.created_at.desc()).first()

        last_sync_time = last_op.created_at.isoformat() if last_op else None

        return {
            "local_version": client_version,
            "server_version": server_version,
            "last_sync_time": last_sync_time,
            "need_sync": need_sync,
        }

    def push(self, db: Session, user_id: str, client_version: int, operations: list[dict]) -> dict:
        """推送本地变更到服务器"""
        kb = db.query(KeyBookMeta).filter(KeyBookMeta.user_id == user_id).first()
        if not kb:
            raise ValueError("密码本不存在")

        conflicts = []
        new_version = kb.version

        for op in operations:
            op_type = op.get("op")
            item_index = op.get("item_id")
            op_data = op.get("data")

            sync_op = SyncOperation(
                keybook_id=kb.id,
                operation_type=op_type,
                item_index=item_index,
                operation_data=json.dumps(op_data, ensure_ascii=False) if op_data else None,
                version=new_version + 1,
            )
            db.add(sync_op)
            new_version += 1

        kb.version = new_version
        db.commit()

        return {
            "server_version": new_version,
            "conflicts": conflicts,
        }

    def pull(self, db: Session, user_id: str, client_version: int) -> dict:
        """拉取服务端变更"""
        kb = db.query(KeyBookMeta).filter(KeyBookMeta.user_id == user_id).first()
        if not kb:
            raise ValueError("密码本不存在")

        ops = db.query(SyncOperation).filter(
            SyncOperation.keybook_id == kb.id,
            SyncOperation.version > client_version,
        ).order_by(SyncOperation.version).all()

        operations = []
        for op in ops:
            op_dict = {
                "op": op.operation_type,
                "item_id": op.item_index,
                "version": op.version,
            }
            if op.operation_data:
                op_dict["data"] = json.loads(op.operation_data)
            operations.append(op_dict)

        return {
            "server_version": kb.version,
            "operations": operations,
        }


sync_service = SyncService()
