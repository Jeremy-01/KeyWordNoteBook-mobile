"""
认证相关数据模型
"""
from pydantic import BaseModel, EmailStr, Field


class RegisterRequest(BaseModel):
    """注册请求"""
    email: EmailStr
    password: str = Field(..., min_length=6, max_length=128)
    password_confirm: str


class LoginRequest(BaseModel):
    """登录请求"""
    email: EmailStr
    password: str


class RefreshRequest(BaseModel):
    """刷新 Token 请求"""
    refresh_token: str


class TokenResponse(BaseModel):
    """Token 响应"""
    access_token: str
    refresh_token: str
    expires_in: int
    token_type: str = "Bearer"


class UserInfo(BaseModel):
    """用户信息"""
    user_id: str
    email: str
    created_at: str
