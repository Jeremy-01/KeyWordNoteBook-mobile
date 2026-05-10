"""
认证路由 - 注册、登录、Token 刷新
"""
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.config import get_settings
from app.schemas.common import ApiResponse
from app.schemas.auth import RegisterRequest, LoginRequest, RefreshRequest, TokenResponse, UserInfo
from app.services.auth_service import auth_service

router = APIRouter(prefix="/auth", tags=["认证"])
settings = get_settings()


@router.post("/register", response_model=ApiResponse, status_code=201)
def register(req: RegisterRequest, request: Request, db: Session = Depends(get_db)):
    """用户注册"""
    if settings.RATE_LIMIT_ENABLED:
        from app.main import limiter
        limiter.check(request, f"{settings.RATE_LIMIT_PER_MINUTE}/minute")
    try:
        result = auth_service.register(db, req)
        return ApiResponse(code=0, message="注册成功", data=result)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/login", response_model=ApiResponse)
def login(req: LoginRequest, request: Request, db: Session = Depends(get_db)):
    """用户登录"""
    if settings.RATE_LIMIT_ENABLED:
        from app.main import limiter
        limiter.check(request, f"{settings.RATE_LIMIT_PER_MINUTE}/minute")
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


@router.get("/me", response_model=ApiResponse)
def get_me(user_id: str = Depends(lambda: None)):
    """获取当前用户信息（占位）"""
    pass
