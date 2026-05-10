# KeyWordNoteBook 安全审查报告

**项目**: KeyWordNoteBook
**日期**: 2026-05-10
**审查范围**: 后端 FastAPI + 移动端 Flutter
**审查人**: Security Best Practices Review

---

## 执行摘要

KeyWordNoteBook 是一个采用端到端加密的密码管理器，包含 FastAPI 后端和 Flutter 移动端。经过代码审查，发现 **8 个高危**、**7 个中危** 和 **5 个低危** 安全问题需要关注。最严重的问题包括：JWT 密钥强度不足、移动端与后端的密钥派生参数不一致（可能导致加密失效）、以及 CORS 配置允许所有来源访问。

---

## 高危问题 (Critical/High)

### [高危-01] JWT 密钥使用弱默认值且可能被硬编码泄露

**影响**: 攻击者可以伪造任意用户的 Token，完全接管账户。

**位置**:

- [server/app/core/config.py:17](file:///workspace/server/app/core/config.py#L17) - `JWT_SECRET_KEY` 默认值
- [server/app/core/security.py:14](file:///workspace/server/app/core/security.py#L14) - 密钥直接使用

**描述**:
```python
# server/app/core/config.py
jwt_secret_key: str = Field(default="keyword-notebook-jwt-secret-key-2024", ...)
```
生产环境中使用了硬编码的默认密钥。如果 `.env` 文件未正确配置，攻击者可以使用该已知密钥签发任意 Token。

**建议**:
1. 在生产环境禁止使用默认密钥，启动时检查并抛出错误
2. 使用 `secrets.token_urlsafe(32)` 生成强随机密钥
3. 密钥通过环境变量注入，永不硬编码

---

### [高危-02] 移动端与后端 PBKDF2 迭代次数不一致

**影响**: 移动端派生的加密密钥与后端不匹配，可能导致数据加密/解密失败或产生安全风险。

**位置**:

- [mobile/lib/core/crypto/crypto_service.dart:52](file:///workspace/mobile/lib/core/crypto/crypto_service.dart#L52) - 移动端 100000 次
- [server/app/core/security.py:21](file:///workspace/server/app/core/security.py#L21) - 后端 480000 次

**描述**:
```dart
// 移动端
iterations: 100000, // crypto_service.dart:52

# 后端
iterations=self.pbkdf2_iterations,  # 480000 security.py:21
```

移动端使用 100,000 次迭代，后端使用 480,000 次迭代。这会导致两端派生的密钥完全不同。

**建议**:
1. 统一迭代次数为至少 480,000 次（或更高）
2. 添加集成测试验证两端密钥派生结果一致

---

### [高危-03] CORS 配置允许所有来源访问

**影响**: 任意网站可以向 API 发起请求，导致 CSRF 攻击和令牌被盗用。

**位置**:

- [server/app/main.py:25-31](file:///workspace/server/app/main.py#L25-L31)

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 允许所有来源
    allow_credentials=True,  # 允许携带凭证
    allow_methods=["*"],
    allow_headers=["*"],
)
```

`allow_origins=["*"]` 配合 `allow_credentials=True` 会导致浏览器拒绝请求，但若攻击者直接调用 API（非浏览器），则无此限制。

**建议**:
1. 明确指定允许的来源列表
2. 生产环境应配置具体的前端域名
3. 考虑使用环境变量控制 CORS 配置

---

### [高危-04] 认证端点无速率限制

**影响**: 攻击者可以进行无限次暴力破解尝试。

**位置**:

- [server/app/api/v1/auth.py:25-32](file:///workspace/server/app/api/v1/auth.py#L25-L32) - `/auth/login`
- [server/app/api/v1/auth.py:15-22](file:///workspace/server/app/api/v1/auth.py#L15-L22) - `/auth/register`

**描述**:
登录和注册端点没有任何速率限制。攻击者可以每秒发起数千次登录尝试，暴力破解用户密码。

**建议**:
1. 使用 slowapi 或中间件实现速率限制
2. 登录尝试失败 5 次后，添加延迟（指数退避）
3. 考虑添加账户锁定机制

---

### [高危-05] 主密码通过 HTTP 头传输

**影响**: 主密码以明文形式在网络中传输，可能被中间人攻击截获。

**位置**:

- [mobile/lib/core/network/api_client.dart:175-180](file:///workspace/mobile/lib/core/network/api_client.dart#L175-L180)
- [server/app/core/deps.py:24-47](file:///workspace/server/app/core/deps.py#L24-L47)

```dart
// 移动端
void setMasterPassword(String password) {
  _dio.options.headers['X-Verify-Password'] = password;
}
```

```python
# 后端
master_pw: str = Depends(verify_master_password)  # 从 HTTP 头读取
```

虽然使用了 HTTPS，但主密码作为明文传输仍然是不推荐的做法。

**建议**:
1. 使用 Diffie-Hellman 密钥交换或其他零知识证明方案
2. 确保所有 API 通信强制使用 HTTPS
3. 考虑在客户端使用主密码派生一个会话密钥

---

### [高危-06] 用户 ID 使用可预测的格式

**影响**: 攻击者可以枚举和预测用户 ID。

**位置**:

- [server/app/services/auth_service.py:29](file:///workspace/server/app/services/auth_service.py#L29)

```python
user_id = f"usr_{uuid.uuid4().hex[:12]}"
```

`usr_` 前缀和 12 字符十六进制格式使得 ID 空间可预测。

**建议**:
1. 使用完整的 UUID v4（36 字符）
2. 或使用不透明的用户 ID（无规律）

---

### [中危-07] 密码条目索引使用自增序号

**影响**: 攻击者可以遍历所有密码条目。

**位置**:

- [server/app/services/keybook_service.py:40-46](file:///workspace/server/app/services/keybook_service.py#L40-L46)

```python
def _get_next_index(self, db: Session, keybook_id: int) -> str:
    items = db.query(KeyItem).filter(...).all()
    max_idx = max(int(item.item_index) for item in items)
    return str(max_idx + 1)
```

密码条目使用自增整数索引，攻击者可以通过遍历 `/keybook/items/1`、`/keybook/items/2` 等获取所有密码。

**建议**:
1. 使用 UUID 作为条目 ID
2. 随机生成不连续的索引
3. 在 API 层验证请求的 `item_id` 确实属于当前用户

---

### [中危-08] 主密码无复杂度要求

**影响**: 用户可能设置弱密码，降低账户安全性。

**位置**:

- [server/app/schemas/auth.py](file:///workspace/server/app/schemas/auth.py) - 注册请求验证

**描述**:
注册时只检查密码长度 >= 8，无其他复杂度要求。

**建议**:
1. 要求至少包含大小写字母、数字
2. 禁止常见弱密码（123456、password 等）
3. 建议最小长度 12 字符

---

## 中危问题 (Medium)

### [中危-09] Token 过期时间未存储

**影响**: 无法准确判断 Token 是否过期。

**位置**:

- [mobile/lib/core/network/token_manager.dart:35-40](file:///workspace/mobile/lib/core/network/token_manager.dart#L35-L40)
- [server/app/core/security.py:50-59](file:///workspace/server/app/core/security.py#L50-L59)

移动端保存了 Token 过期时间，但后端生成 Token 时没有将过期时间包含在 Token payload 中。

**建议**:
1. 在 JWT payload 中包含 `exp` 和 `iat` 声明
2. 验证 Token 时检查 `exp` 声明

---

### [中危-10] 调试模式可能在生产环境启用

**影响**: 调试模式会泄露敏感信息和堆栈跟踪。

**位置**:

- [server/app/main.py:21](file:///workspace/server/app/main.py#L21) - `debug=settings.DEBUG`

```python
app = FastAPI(
    ...
    debug=settings.DEBUG,
)
```

**建议**:
1. 生产环境强制 `DEBUG=False`
2. 使用 Pydantic Settings 验证配置

---

### [中危-11] 积分检查使用占位符

**影响**: 数据完整性验证可能失效。

**位置**:

- [server/app/services/auth_service.py:131](file:///workspace/server/app/services/auth_service.py#L131)

```python
integrity_check="0" * 64,  # 初始值，后续更新
```

初始完整性检查值固定为 64 个零，没有实际验证功能。

**建议**:
1. 使用首次加密数据计算真实 HMAC
2. 实现定期完整性验证

---

### [中危-12] URL 字段无输入验证

**影响**: 可能存储恶意内容或导致 XSS。

**位置**:

- [server/app/schemas/keybook.py](file:///workspace/server/app/schemas/keybook.py)

URL 和 note 字段没有长度限制或格式验证。

**建议**:
1. 限制 URL 长度（如 2048 字符）
2. 验证 URL 格式（可选）
3. 对 note 内容进行适当的转义

---

### [中危-13] 无账户锁定机制

**影响**: 暴力破解攻击难以被阻止。

**位置**:

- 全局

连续登录失败后没有账户锁定机制。

**建议**:
1. 连续失败 5-10 次后锁定账户 15-30 分钟
2. 使用 Redis 等缓存记录失败次数

---

### [中危-14] 无 Token 撤销机制

**影响**: 登出后 Token 仍然有效。

**位置**:

- [server/app/api/v1/auth.py](file:///workspace/server/app/api/v1/auth.py)

JWT Token 一旦签发，在过期前无法撤销。

**建议**:
1. 使用短期 Token（如 15 分钟）+ Refresh Token
2. Refresh Token 存储在数据库，用于撤销
3. 或使用 Token 黑名单

---

### [低危-15] 错误信息可能泄露用户存在性

**影响**: 枚举攻击可确定哪些邮箱已注册。

**位置**:

- [server/app/services/auth_service.py:26](file:///workspace/server/app/services/auth_service.py#L26)

```python
raise ValueError("该邮箱已被注册")
```

类似地，登录失败时"邮箱或密码错误"是通用的，但注册时明确告知邮箱已被注册。

**建议**:
1. 注册时也返回通用消息："注册成功或邮箱已存在"
2. 或使用相同的时间响应避免时序攻击

---

## 低危问题 (Low)

### [低危-16] 移动端日志可能泄露敏感信息

**位置**:

- [mobile/lib/core/network/api_client.dart:49-54](file:///workspace/mobile/lib/core/network/api_client.dart#L49-L54)

调试日志可能打印敏感数据。

**建议**:
1. 生产环境禁用 API 调试日志
2. 日志脱敏处理

---

### [低危-17] 无 CSP 安全头

**位置**:

- [server/app/main.py](file:///workspace/server/app/main.py)

FastAPI 没有配置安全响应头。

**建议**:
1. 添加 `X-Content-Type-Options: nosniff`
2. 添加 `X-Frame-Options: DENY`
3. 添加 `Strict-Transport-Security`（如使用 HTTPS）

---

### [低危-18] 数据库文件权限

**位置**:

- SQLite 数据库文件

数据库文件应设置适当的文件权限，防止未授权访问。

**建议**:
1. 数据库文件权限设为 600
2. 存储目录权限设为 700

---

### [低危-19] 无审计日志

**位置**:

- 全局

缺少对敏感操作的审计记录。

**建议**:
1. 记录登录/登出事件
2. 记录密码访问操作
3. 记录管理操作

---

### [低危-20] 无 API 版本控制策略

**位置**:

- [server/app/main.py](file:///workspace/server/app/main.py)

API 没有版本化，长远来看难以安全地弃用旧版本。

**建议**:
1. 使用 URL 路径版本控制（如 `/api/v1/`）
2. 维护 API 版本策略

---

## 安全最佳实践符合情况

| 类别 | 状态 | 说明 |
|------|------|------|
| 密码存储 | ✅ | 使用 Argon2id 哈希 |
| 传输加密 | ⚠️ | 依赖 HTTPS（需确保配置） |
| 端到端加密 | ⚠️ | AES-256-GCM 已实现，但参数不一致 |
| 密钥管理 | ❌ | 使用弱默认密钥 |
| 会话管理 | ⚠️ | JWT 实现基本正确，但无撤销机制 |
| 输入验证 | ⚠️ | 缺少部分验证 |
| 速率限制 | ❌ | 无速率限制 |
| CORS | ❌ | 允许所有来源 |
| 安全头 | ❌ | 未配置 |
| 审计日志 | ❌ | 无审计 |

---

## 优先修复建议

### 第一优先级（立即修复）

1. **JWT 密钥配置**
   - 移除硬编码默认值
   - 启动时验证密钥强度

2. **PBKDF2 参数统一**
   - 移动端迭代次数改为 480,000

3. **CORS 配置**
   - 生产环境限制允许的来源

### 第二优先级（尽快修复）

4. **添加速率限制**
5. **实现账户锁定**
6. **用户 ID 格式改进**
7. **条目 ID 使用 UUID**

### 第三优先级（计划修复）

8. **添加 Token 撤销机制**
9. **完善输入验证**
10. **添加安全响应头**

---

## 总结

KeyWordNoteBook 在加密实现方面有良好的基础（Argon2id、AES-256-GCM），但在实际部署前需要解决上述安全问题。最关键的是 JWT 密钥配置、PBKDF2 参数不一致和 CORS 配置问题。密码管理器处理的是高度敏感的数据，安全问题不应忽视。

---

*报告生成时间: 2026-05-10*
*工具: security-best-practices*
