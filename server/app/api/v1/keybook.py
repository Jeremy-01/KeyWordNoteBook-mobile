"""
密码本路由 - 密码条目 CRUD
"""
from fastapi import APIRouter, Depends, HTTPException, Header
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.deps import get_current_user_id, verify_master_password
from app.schemas.common import ApiResponse
from app.schemas.keybook import KeyItemCreate, KeyItemUpdate
from app.services.keybook_service import keybook_service

router = APIRouter(prefix="/keybook", tags=["密码本"])


@router.get("/items", response_model=ApiResponse)
def get_items(
    page: int = 1,
    page_size: int = 20,
    user_id: str = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    """获取密码条目列表（非敏感字段）"""
    try:
        result = keybook_service.get_items(db, user_id, page, page_size)
        return ApiResponse(code=0, data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/items/{item_id}", response_model=ApiResponse)
def get_item_detail(
    item_id: str,
    user_id: str = Depends(get_current_user_id),
    master_pw: str = Depends(verify_master_password),
    db: Session = Depends(get_db),
):
    """获取单个条目详情（含解密密码，需二次验证）"""
    try:
        result = keybook_service.get_item_detail(db, user_id, item_id, master_pw)
        return ApiResponse(code=0, data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/items", response_model=ApiResponse, status_code=201)
def add_item(
    data: KeyItemCreate,
    user_id: str = Depends(get_current_user_id),
    master_pw: str = Depends(verify_master_password),
    db: Session = Depends(get_db),
):
    """添加密码条目（需二次验证）"""
    try:
        item_id = keybook_service.add_item(db, user_id, data, master_pw)
        return ApiResponse(code=0, message="添加成功", data={"item_id": item_id})
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.put("/items/{item_id}", response_model=ApiResponse)
def update_item(
    item_id: str,
    data: KeyItemUpdate,
    user_id: str = Depends(get_current_user_id),
    master_pw: str = Depends(verify_master_password),
    db: Session = Depends(get_db),
):
    """更新密码条目（需二次验证）"""
    try:
        keybook_service.update_item(db, user_id, item_id, data, master_pw)
        return ApiResponse(code=0, message="更新成功")
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/items/{item_id}", response_model=ApiResponse)
def delete_item(
    item_id: str,
    user_id: str = Depends(get_current_user_id),
    master_pw: str = Depends(verify_master_password),
    db: Session = Depends(get_db),
):
    """删除密码条目（需二次验证）"""
    try:
        keybook_service.delete_item(db, user_id, item_id, master_pw)
        return ApiResponse(code=0, message="删除成功")
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
