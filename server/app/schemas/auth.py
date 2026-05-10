"""
认证相关数据模型
"""
import re
from pydantic import BaseModel, EmailStr, Field, validator


COMMON_PASSWORDS = {
    "password", "123456", "123456789", "12345678", "1234567",
    "qwerty", "abc123", "monkey", "1234567890", "letmein",
    "trustno1", "dragon", "baseball", "iloveyou", "master",
    "sunshine", "ashley", "football", "shadow", "123123",
    "654321", "superman", "qazwsx", "michael", "password1",
    "password123", "welcome", "welcome1", "admin", "login"
}


def validate_password_strength(password: str) -> str:
    """验证密码强度"""
    if len(password) < 8:
        raise ValueError("密码长度至少为 8 个字符")
    if len(password) > 128:
        raise ValueError("密码长度不能超过 128 个字符")
    if not re.search(r"[a-z]", password):
        raise ValueError("密码必须包含至少一个小写字母")
    if not re.search(r"[A-Z]", password):
        raise ValueError("密码必须包含至少一个大写字母")
    if not re.search(r"\d", password):
        raise ValueError("密码必须包含至少一个数字")
    if password.lower() in COMMON_PASSWORDS:
        raise ValueError("密码太简单，请使用更复杂的密码")
    weak_patterns = [
        r"^(.)\1{4,}$",  # 重复字符
        r"^123456|654321|111111|abcdef",
    ]
    for pattern in weak_patterns:
        if re.search(pattern, password.lower()):
            raise ValueError("密码包含弱模式，请使用更复杂的密码")
    return password


class RegisterRequest(BaseModel):
    """注册请求"""
    email: EmailStr
    password: str = Field(..., min_length=8, max_length=128)
    password_confirm: str

    @validator("password")
    def validate_password(cls, v):
        return validate_password_strength(v)

    @validator("password_confirm")
    def passwords_match(cls, v, values):
        if "password" in values and v != values["password"]:
            raise ValueError("两次输入的密码不一致")
        return v


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
