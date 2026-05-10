"""
公共依赖模块 - 用于 FastAPI 依赖注入
"""
from fastapi import Depends, HTTPException, Header
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.core.security import security_service


def get_current_user_id(authorization: str = Header(...)) -> str:
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


def verify_master_password(x_verify_password: str = Header(...)) -> str:
    """提取二次验证密码"""
    if not x_verify_password:
        raise HTTPException(status_code=400, detail="需要二次密码验证")
    return x_verify_password
