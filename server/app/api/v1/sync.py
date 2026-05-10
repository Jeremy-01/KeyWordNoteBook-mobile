"""
同步路由 - 数据同步
"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.deps import get_current_user_id
from app.schemas.common import ApiResponse
from app.schemas.keybook import SyncPushRequest, SyncPullRequest
from app.services.sync_service import sync_service

router = APIRouter(prefix="/sync", tags=["同步"])


@router.get("/status", response_model=ApiResponse)
def get_sync_status(
    client_version: int = 0,
    user_id: str = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    """获取同步状态"""
    try:
        result = sync_service.get_status(db, user_id, client_version)
        return ApiResponse(code=0, data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/push", response_model=ApiResponse)
def push_changes(
    req: SyncPushRequest,
    user_id: str = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    """推送本地变更到服务器"""
    try:
        result = sync_service.push(db, user_id, req.client_version, req.operations)
        return ApiResponse(code=0, data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/pull", response_model=ApiResponse)
def pull_changes(
    req: SyncPullRequest,
    user_id: str = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    """拉取服务端变更"""
    try:
        result = sync_service.pull(db, user_id, req.client_version)
        return ApiResponse(code=0, data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
