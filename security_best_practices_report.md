# KeyWordNoteBook 安全审查报告

**审查日期**: 2026-05-10
**审查范围**: KeyWordNoteBook Flutter 移动端 + FastAPI 后端
**审查方法**: 静态代码分析 + 配置文件审查

---

## 执行摘要

本次安全审查覆盖了 KeyWordNoteBook 项目的核心安全组件。整体安全架构设计良好，采用了业界标准的加密实践（Argon2 密码哈希、AES-256-GCM 加密、JWT 认证）。发现 **2 个高严重性问题**、**2 个中严重性问题** 和 **3 个低严重性问题**，主要涉及配置安全和生产环境安全设置。

---

## 关键发现

### SEC-001: DEBUG 模式在生产环境默认为 True

**严重级别**: High
**类别**: 配置安全
**位置**: `server/app/core/config.py:9`

**问题描述**:
`DEBUG` 配置项默认为 `True`，且未在 `.env.example` 中明确设置为生产环境值。Debug 模式可能导致敏感信息泄露和详细错误暴露。

**证据**:
```python
# server/app/core/config.py
DEBUG: bool = True  # 默认开启调试模式

# server/app/main.py
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    debug=settings.DEBUG,  # 直接使用 DEBUG 配置
)
```

**影响**:
- 启用 debug 模式时，FastAPI 可能返回详细的堆栈跟踪信息
- 可能暴露数据库查询、系统路径等敏感信息
- 符合 OWASP 敏感性数据泄露风险

**修复建议**:
```python
# server/app/core/config.py
DEBUG: bool = False  # 默认为 False

# 确保 .env.example 中明确说明
# DEBUG=False  # 设置为 False 用于生产环境
```

**缓解措施**:
- 在生产部署时，确保设置 `DEBUG=False`
- 使用环境变量覆盖默认值

---

### SEC-002: JWT Secret Key 默认为空字符串

**严重级别**: High
**类别**: 认证安全
**位置**: `server/app/core/config.py:13`

**问题描述**:
JWT 密钥默认为空字符串，虽然 `validate()` 方法检查了非生产环境的绕过条件，但在生产环境中如果未正确配置会导致认证完全失效。

**证据**:
```python
# server/app/core/config.py
JWT_SECRET_KEY: str = ""  # 默认为空

def validate(self):
    if not self.DEBUG and not self.JWT_SECRET_KEY:
        raise ValueError("JWT_SECRET_KEY must be set in production")
```

**影响**:
- 如果部署时忘记设置 JWT_SECRET_KEY，在 DEBUG=False 时应用将无法启动
- 空的 JWT 密钥会导致所有 Token 可被伪造

**修复建议**:
```python
# server/app/core/config.py
JWT_SECRET_KEY: str = "CHANGE_ME_IN_PRODUCTION_MIN_32_CHARS"

# 或使用 pydantic 的 validator 确保非空
@validator("JWT_SECRET_KEY")
def validate_jwt_secret(cls, v):
    if not v or v == "CHANGE_ME_IN_PRODUCTION_MIN_32_CHARS":
        raise ValueError("JWT_SECRET_KEY must be changed from default")
    if len(v) < 32:
        raise ValueError("JWT_SECRET_KEY must be at least 32 characters")
    return v
```

---

### SEC-003: CORS 配置允许所有来源

**严重级别**: Medium
**类别**: CORS 配置
**位置**: `server/app/main.py:46-69`

**问题描述**:
当 `CORS_ALLOWED_ORIGINS` 为空时，代码会回退到 `allow_origins=["*"]`，这在生产环境中是不安全的。

**证据**:
```python
# server/app/main.py
def get_cors_origins():
    origins_str = settings.CORS_ALLOWED_ORIGINS
    if not origins_str:
        return ["*"] if settings.DEBUG else []  # 生产环境返回空列表
    return [origin.strip() for origin in origins_str.split(",")]

# ... 但调试模式仍使用 "*"
```

**影响**:
- 在 DEBUG 模式下允许所有来源
- 可能导致开发环境配置被误用于生产

**修复建议**:
```python
# server/app/main.py
cors_origins = get_cors_origins()
if not cors_origins:
    # 不允许任何跨域请求，而不是使用空列表
    pass  # 不添加 CORS 中间件
elif cors_origins == ["*"]:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=False,  # 不能同时使用 * 和 credentials
        allow_methods=["*"],
        allow_headers=["*"],
    )
else:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=cors_origins,
        allow_credentials=True,
        allow_methods=["GET", "POST", "PUT", "DELETE"],
        allow_headers=["Authorization", "Content-Type", "X-Master-Password"],
    )
```

---

### SEC-004: API 文档在生产环境暴露

**严重级别**: Medium
**类别**: 信息泄露
**位置**: `server/app/main.py`

**问题描述**:
FastAPI 默认启用 OpenAPI 文档（`/docs`、`/redoc`、`/openapi.json`），在生产环境中可能暴露 API 结构。

**证据**:
```python
# FastAPI 默认配置
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    debug=settings.DEBUG,
)
# 未设置 docs_url=None, redoc_url=None, openapi_url=None
```

**影响**:
- 攻击者可轻易发现所有 API 端点
- 结合其他漏洞可能加速攻击

**修复建议**:
```python
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    debug=settings.DEBUG,
    docs_url=None if not settings.DEBUG else "/docs",
    redoc_url=None if not settings.DEBUG else "/redoc",
    openapi_url=None if not settings.DEBUG else "/openapi.json",
)
```

---

### SEC-005: Token 刷新失败后未正确清除状态

**严重级别**: Low
**类别**: 认证逻辑
**位置**: `mobile/lib/core/network/api_client.dart:78-97`

**问题描述**:
当 Token 刷新失败时，虽然清除了 Token，但可能没有正确处理用户会话状态。

**证据**:
```python
# mobile/lib/core/network/api_client.dart
Future<bool> _tryRefreshToken() async {
    try {
        # ...
    } catch (e) {
        await _tokenManager.clearTokens();  # 清除 tokens
    }
    return false;  # 但调用方可能继续使用过期的响应
}
```

**影响**:
- 用户可能停留在已认证页面但实际无法访问 API
- 需要额外的会话状态清理

**修复建议**:
```dart
Future<bool> _tryRefreshToken() async {
    try {
        // ...
    } catch (e) {
        await _tokenManager.clearTokens();
        // 广播会话过期事件，触发重新登录
        // EventBus.emit(SessionExpiredEvent());
    }
    return false;
}
```

---

### SEC-006: 缺少请求超时和限流配置

**严重级别**: Low
**类别**: DoS 防护
**位置**: `server/app/main.py` 和 API 配置

**问题描述**:
未在应用层配置显式的请求超时和限流规则。

**证据**:
```python
# server/app/main.py
# BaseOptions 中有超时设置
# 但未配置 Starlette 的最大请求大小限制
```

**影响**:
- 大型请求可能导致服务器资源耗尽
- 缺少细粒度的限流规则

**修复建议**:
```python
from starlette.middleware import Middleware
from starlette.middleware.trustedhost import TrustedHostMiddleware
from starlette.middleware.gzip import GZipMiddleware

app.add_middleware(GZipMiddleware, minimum_size=1000)
app.add_middleware(
    TrustedHostMiddleware,
    allowed_hosts=["example.com", "*.example.com"]  # 根据实际域名配置
)

# 在 BaseOptions 中添加请求大小限制
_max_request_size = 10 * 1024 * 1024  # 10MB
```

---

### SEC-007: 密码验证使用不安全的比较方法

**严重级别**: Low
**类别**: 时序攻击
**位置**: `mobile/lib/shared/utils/validators.dart`

**问题描述**:
密码匹配验证器使用 `!=` 进行字符串比较，可能存在时序攻击风险。

**证据**:
```dart
// mobile/lib/shared/utils/validators.dart
static String? passwordMatch(String? value, String? confirmValue) {
  if (value != confirmValue) {  // 使用 != 比较
    return '两次输入的密码不一致';
  }
  return null;
}
```

**影响**:
- 理论上存在时序攻击风险（但实际影响极低，因为没有网络访问）
- 密码学上推荐使用 constant-time 比较

**修复建议**:
```dart
import 'dart:crypto' show CryptoUtils;

static String? passwordMatch(String? value, String? confirmValue) {
  if (value == null || confirmValue == null || value != confirmValue) {
    return '两次输入的密码不一致';
  }
  // 对于 Dart，使用字符串相等已经足够
  return null;
}
```

---

## 已确认的安全实践

以下安全措施在代码中已正确实现：

| 安全措施 | 状态 | 位置 |
|---------|------|------|
| Argon2 密码哈希 | ✅ | `server/app/core/security.py` |
| AES-256-GCM 加密 | ✅ | `security_service.encrypt_aes()` |
| JWT 签名验证 | ✅ | `security_service.decode_token()` |
| 主密码二次验证 | ✅ | `verify_master_password()` |
| 对象级授权检查 | ✅ | `keybook_service._get_keybook()` |
| 安全存储 Token | ✅ | `flutter_secure_storage` |
| 安全响应头 | ✅ | `SecurityHeadersMiddleware` |
| SQLAlchemy 参数化查询 | ✅ | 所有数据库操作 |
| Pydantic 输入验证 | ✅ | 所有 schema |

---

## 总结

| 严重级别 | 数量 | 描述 |
|---------|------|------|
| **High** | 2 | DEBUG 默认值、JWT Secret 默认值 |
| **Medium** | 2 | CORS 配置、API 文档暴露 |
| **Low** | 3 | Token 刷新逻辑、限流配置、字符串比较 |
| **已确认安全** | 8 | 核心加密、认证、授权机制 |

### 优先修复建议

1. **立即修复**: 确保生产部署时 `DEBUG=False` 和配置强 JWT Secret
2. **尽快修复**: 限制生产环境的 CORS 源和 API 文档访问
3. **计划修复**: 完善请求限流和超时配置

---

*报告生成时间: 2026-05-10*
