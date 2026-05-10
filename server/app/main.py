"""
FastAPI 应用入口
"""
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded

from app.core.config import get_settings
from app.core.database import engine, Base
from app.api.v1.auth import router as auth_router
from app.api.v1.keybook import router as keybook_router
from app.api.v1.sync import router as sync_router

settings = get_settings()

# 创建所有数据库表
Base.metadata.create_all(bind=engine)

# 速率限制器
limiter = Limiter(key_func=get_remote_address)

app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    debug=settings.DEBUG,
)

app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)


class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        response = await call_next(request)
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        return response


# CORS 中间件 - 根据配置限制来源
def get_cors_origins():
    origins_str = settings.CORS_ALLOWED_ORIGINS
    if not origins_str:
        return ["*"] if settings.DEBUG else []
    return [origin.strip() for origin in origins_str.split(",")]


cors_origins = get_cors_origins()
if cors_origins != ["*"]:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=cors_origins,
        allow_credentials=True,
        allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        allow_headers=["Authorization", "Content-Type", "X-Master-Password"],
    )
else:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=False,
        allow_methods=["*"],
        allow_headers=["*"],
    )

app.add_middleware(SecurityHeadersMiddleware)

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
