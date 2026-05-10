"""
FastAPI 应用入口
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import get_settings
from app.core.database import engine, Base
from app.api.v1.auth import router as auth_router
from app.api.v1.keybook import router as keybook_router
from app.api.v1.sync import router as sync_router

settings = get_settings()

# 创建所有数据库表
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    debug=settings.DEBUG,
)

# CORS 中间件
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 注册路由
app.include_router(auth_router, prefix="/api/v1")
app.include_router(keybook_router, prefix="/api/v1")
app.include_router(sync_router, prefix="/api/v1")


@app.get("/")
def root():
    return {"name": settings.APP_NAME, "version": settings.APP_VERSION}


@app.get("/health")
def health_check():
    return {"status": "ok"}
