"""
密码本相关数据模型
"""
from pydantic import BaseModel, Field, validator
import re


class KeyItemCreate(BaseModel):
    """创建密码条目"""
    url: str = Field(..., min_length=1, max_length=2048)
    username: str = Field(..., min_length=1, max_length=256)
    password: str = Field(..., min_length=1, max_length=1024)
    link_url: str = Field(default="", max_length=2048)
    note: str = Field(default="", max_length=10000)

    @validator("url", "link_url")
    def validate_url_format(cls, v):
        if v and not re.match(r'^https?://', v):
            v = f"https://{v}"
        return v


class KeyItemUpdate(BaseModel):
    """更新密码条目"""
    url: str | None = Field(default=None, max_length=2048)
    username: str | None = Field(default=None, max_length=256)
    password: str | None = Field(default=None, max_length=1024)
    link_url: str | None = Field(default=None, max_length=2048)
    note: str | None = Field(default=None, max_length=10000)

    @validator("url", "link_url")
    def validate_url_format(cls, v):
        if v and not re.match(r'^https?://', v):
            v = f"https://{v}"
        return v


class KeyItemResponse(BaseModel):
    """密码条目响应（非敏感字段）"""
    index: str
    url: str
    username: str
    password_level: int
    link_url: str
    note: str


class KeyItemDetailResponse(KeyItemResponse):
    """密码条目详情（含解密密码）"""
    password: str


class SyncPushRequest(BaseModel):
    """同步推送请求"""
    client_version: int
    operations: list[dict]


class SyncPullRequest(BaseModel):
    """同步拉取请求"""
    client_version: int


class SyncStatusResponse(BaseModel):
    """同步状态响应"""
    local_version: int
    server_version: int
    last_sync_time: str | None
    need_sync: bool
