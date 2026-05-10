"""
认证路由 - 注册、登录、Token 刷新
"""
from fastapi import APIRouter, Depends, HTTPException, Request, Header
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.config import get_settings
from app.core.security import security_service
from app.schemas.common import ApiResponse
from app.schemas.auth import RegisterRequest, LoginRequest, RefreshRequest, TokenResponse, UserInfo
from app.services.auth_service import auth_service

router = APIRouter(prefix="/auth", tags=["认证"])
settings = get_settings()


@router.post("/register", response_model=ApiResponse, status_code=201)
def register(req: RegisterRequest, request: Request, db: Session = Depends(get_db)):
    """用户注册"""
    try:
        result = auth_service.register(db, req)
        return ApiResponse(code=0, message="注册成功", data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/login", response_model=ApiResponse)
def login(req: LoginRequest, request: Request, db: Session = Depends(get_db)):
    """用户登录"""
    try:
        result = auth_service.login(db, req)
        return ApiResponse(code=0, message="登录成功", data=result)
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))


@router.post("/refresh", response_model=ApiResponse)
def refresh_token(req: RefreshRequest, db: Session = Depends(get_db)):
    """刷新访问令牌"""
    try:
        result = auth_service.refresh_token(db, req.refresh_token)
        return ApiResponse(code=0, message="刷新成功", data=result)
    except ValueError as e:
        raise HTTPException(status_code=401, detail=str(e))


def get_current_user_id_from_token(authorization: str = Header(...)) -> str:
    """从 Authorization 头中提取当前用户ID"""
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="无效的认证格式")
    token = authorization[7:]
    payload = security_service.decode_token(token)
    if payload is None:
        raise HTTPException(status_code=401, detail="Token 无效或已过期")
    if payload.get("type") != "access":
        raise HTTPException(status_code=401, detail="需要访问令牌")
    return payload.get("sub")


@router.get("/me", response_model=ApiResponse)
def get_me(
    user_id: str = Depends(get_current_user_id_from_token),
    db: Session = Depends(get_db),
):
    """获取当前用户信息"""
    try:
        result = auth_service.get_user_info(db, user_id)
        return ApiResponse(code=0, message="获取成功", data=result)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
