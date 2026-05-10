# KeyWordNoteBook API

后端 RESTful API 服务，为 KeyWordNoteBook 移动端提供认证、密码本管理和数据同步功能。

## 目录

- [快速开始](#快速开始)
- [API 概览](#api-概览)
- [认证](#认证)
- [密码本](#密码本)
- [同步](#同步)
- [数据模型](#数据模型)
- [错误处理](#错误处理)
- [安全机制](#安全机制)

---

## 快速开始

### 1. 安装依赖

```bash
cd server

# 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Linux/macOS
# venv\Scripts\activate  # Windows

# 安装依赖
pip install -r requirements.txt
```

### 2. 配置环境变量

```bash
cp .env.example .env
```

编辑 `.env` 文件：

```env
DATABASE_URL=sqlite:///./keybook.db
JWT_SECRET_KEY=your-secret-key-change-in-production
DEBUG=True
```

### 3. 启动服务

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 4. 验证服务

```bash
# 健康检查
curl http://localhost:8000/health
# 返回: {"status": "ok"}

# 访问 API 文档
# http://localhost:8000/docs (Swagger UI)
# http://localhost:8000/redoc (ReDoc)
```

---

## API 概览

### 基础信息

| 项目 | 说明 |
|------|------|
| 基础 URL | `http://localhost:8000/api/v1` |
| 认证方式 | JWT Bearer Token |
| 数据格式 | JSON |
| 字符编码 | UTF-8 |

### 端点列表

| 模块 | 端点 | 方法 | 认证 | 说明 |
|------|------|------|------|------|
| **认证** | `/auth/register` | POST | 否 | 用户注册 |
| | `/auth/login` | POST | 否 | 用户登录 |
| | `/auth/refresh` | POST | 否 | 刷新令牌 |
| **密码本** | `/keybook/items` | GET | 是 | 获取密码列表 |
| | `/keybook/items/{id}` | GET | 是 + 主密码 | 获取密码详情 |
| | `/keybook/items` | POST | 是 + 主密码 | 添加密码 |
| | `/keybook/items/{id}` | PUT | 是 + 主密码 | 更新密码 |
| | `/keybook/items/{id}` | DELETE | 是 + 主密码 | 删除密码 |
| **同步** | `/sync/status` | GET | 是 | 获取同步状态 |
| | `/sync/push` | POST | 是 | 推送本地变更 |
| | `/sync/pull` | POST | 是 | 拉取服务端变更 |

### 统一响应格式

```json
{
  "code": 0,
  "message": "操作成功",
  "data": { ... }
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `code` | integer | 状态码，0 表示成功 |
| `message` | string | 响应消息 |
| `data` | object | 响应数据 |

---

## 认证

### 用户注册

创建新用户账户。

**请求**

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "master_password": "secure_password123"
}
```

**参数说明**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| email | string | 是 | 邮箱地址，有效格式 |
| master_password | string | 是 | 主密码，最少 8 字符 |

**响应成功**

```json
{
  "code": 0,
  "message": "注册成功",
  "data": {
    "user_id": "uuid-string",
    "email": "user@example.com"
  }
}
```

**响应失败**

```json
{
  "detail": "邮箱已被注册"
}
```

---

### 用户登录

登录获取访问令牌。

**请求**

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "master_password": "secure_password123"
}
```

**响应成功**

```json
{
  "code": 0,
  "message": "登录成功",
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
    "token_type": "bearer",
    "expires_in": 3600
  }
}
```

**Token 说明**

| Token 类型 | 过期时间 | 用途 |
|-----------|---------|------|
| access_token | 60 分钟 | API 访问认证 |
| refresh_token | 7 天 | 刷新 access_token |

---

### 刷新令牌

获取新的访问令牌。

**请求**

```http
POST /api/v1/auth/refresh
Content-Type: application/json

{
  "refresh_token": "eyJhbGciOiJIUzI1NiIs..."
}
```

**响应成功**

```json
{
  "code": 0,
  "message": "刷新成功",
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "expires_in": 3600
  }
}
```

---

## 密码本

### 获取密码列表

获取用户的密码条目列表（不含密码明文）。

**请求**

```http
GET /api/v1/keybook/items?page=1&page_size=20
Authorization: Bearer <access_token>
```

**参数说明**

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| page | integer | 否 | 1 | 页码 |
| page_size | integer | 否 | 20 | 每页数量 |

**响应成功**

```json
{
  "code": 0,
  "data": {
    "items": [
      {
        "index": 1,
        "url": "https://example.com",
        "username": "user@example.com",
        "notes": "测试账号",
        "password_level": 4,
        "created_at": "2026-05-10T10:00:00Z",
        "updated_at": "2026-05-10T10:00:00Z"
      }
    ],
    "total": 50,
    "page": 1,
    "page_size": 20
  }
}
```

> **注意**: 密码列表不包含密码明文，需要单独获取详情。

---

### 获取密码详情

获取单个密码条目的完整信息（含密码明文）。

**请求**

```http
GET /api/v1/keybook/items/1
Authorization: Bearer <access_token>
X-Master-Password: secure_password123
```

**请求头说明**

| 头 | 必填 | 说明 |
|----|------|------|
| Authorization | 是 | Bearer Token |
| X-Master-Password | 是 | 主密码，用于解密 |

**响应成功**

```json
{
  "code": 0,
  "data": {
    "index": 1,
    "url": "https://example.com",
    "username": "user@example.com",
    "password": "actual_password",
    "notes": "测试账号",
    "password_level": 4,
    "created_at": "2026-05-10T10:00:00Z",
    "updated_at": "2026-05-10T10:00:00Z"
  }
}
```

---

### 添加密码

创建新的密码条目。

**请求**

```http
POST /api/v1/keybook/items
Authorization: Bearer <access_token>
X-Master-Password: secure_password123
Content-Type: application/json

{
  "url": "https://example.com",
  "username": "user@example.com",
  "password": "new_password",
  "notes": "测试账号"
}
```

**参数说明**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| url | string | 是 | 网站或应用 URL |
| username | string | 是 | 用户名 |
| password | string | 是 | 密码 |
| notes | string | 否 | 备注 |

**响应成功**

```json
{
  "code": 0,
  "message": "添加成功",
  "data": {
    "index": 2
  }
}
```

---

### 更新密码

修改现有密码条目。

**请求**

```http
PUT /api/v1/keybook/items/1
Authorization: Bearer <access_token>
X-Master-Password: secure_password123
Content-Type: application/json

{
  "url": "https://example.com",
  "username": "new_email@example.com",
  "password": "updated_password",
  "notes": "更新后的备注"
}
```

**响应成功**

```json
{
  "code": 0,
  "message": "更新成功"
}
```

---

### 删除密码

删除密码条目（软删除）。

**请求**

```http
DELETE /api/v1/keybook/items/1
Authorization: Bearer <access_token>
X-Master-Password: secure_password123
```

**响应成功**

```json
{
  "code": 0,
  "message": "删除成功"
}
```

> **说明**: 密码采用软删除，数据仍然保留，可在垃圾箱中恢复。

---

## 同步

### 获取同步状态

检查需要同步的数据版本。

**请求**

```http
GET /api/v1/sync/status?client_version=5
Authorization: Bearer <access_token>
```

**参数说明**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| client_version | integer | 是 | 客户端当前版本号 |

**响应成功**

```json
{
  "code": 0,
  "data": {
    "server_version": 10,
    "has_updates": true,
    "pending_operations": 3
  }
}
```

---

### 推送变更

将本地变更推送到服务端。

**请求**

```http
POST /api/v1/sync/push
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "client_version": 5,
  "operations": [
    {
      "type": "CREATE",
      "item_index": 1,
      "data": {
        "url": "https://example.com",
        "username": "user@example.com",
        "password": "encrypted_password",
        "notes": ""
      },
      "timestamp": "2026-05-10T10:00:00Z"
    }
  ]
}
```

**参数说明**

| 参数 | 类型 | 说明 |
|------|------|------|
| client_version | integer | 客户端版本 |
| operations | array | 变更操作列表 |

**操作类型**

| 类型 | 说明 |
|------|------|
| CREATE | 新建密码条目 |
| UPDATE | 更新密码条目 |
| DELETE | 删除密码条目 |

**响应成功**

```json
{
  "code": 0,
  "data": {
    "new_version": 6,
    "conflicts": []
  }
}
```

---

### 拉取变更

从服务端获取变更。

**请求**

```http
POST /api/v1/sync/pull
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "client_version": 5
}
```

**响应成功**

```json
{
  "code": 0,
  "data": {
    "server_version": 10,
    "operations": [
      {
        "type": "UPDATE",
        "item_index": 1,
        "data": { ... },
        "timestamp": "2026-05-10T12:00:00Z"
      }
    ]
  }
}
```

---

## 数据模型

### 用户 (User)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 用户唯一标识 |
| email | String | 邮箱地址，唯一索引 |
| password_hash | String | Argon2 密码哈希 |
| created_at | DateTime | 创建时间 |
| updated_at | DateTime | 更新时间 |

### 密码条目 (KeyBook)

| 字段 | 类型 | 说明 |
|------|------|------|
| index | Integer | 条目序号，本用户内唯一 |
| user_id | UUID | 所属用户 ID |
| url | String | 网站/应用 URL |
| username | String | 用户名 |
| password_encrypted | String | 加密后的密码 |
| notes | String | 备注 |
| password_level | Integer | 密码强度等级 (0-4) |
| created_at | DateTime | 创建时间 |
| updated_at | DateTime | 更新时间 |
| deleted_at | DateTime | 删除时间（软删除） |
| version | Integer | 版本号（乐观锁） |

### 同步操作 (SyncOperation)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 操作唯一标识 |
| user_id | UUID | 用户 ID |
| operation_type | String | 操作类型 |
| item_index | Integer | 关联的密码条目序号 |
| data | JSON | 操作数据 |
| timestamp | DateTime | 操作时间 |
| synced | Boolean | 是否已同步 |

---

## 错误处理

### HTTP 状态码

| 状态码 | 说明 |
|--------|------|
| 200 | 请求成功 |
| 201 | 创建成功 |
| 400 | 请求参数错误 |
| 401 | 未认证或 Token 无效 |
| 403 | 无权限（主密码验证失败） |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

### 错误响应格式

```json
{
  "detail": "错误描述信息"
}
```

### 常见错误

| 状态码 | 场景 | 错误信息 |
|--------|------|---------|
| 400 | 邮箱格式错误 | "邮箱格式不正确" |
| 400 | 密码太短 | "密码长度至少为 8 个字符" |
| 400 | 邮箱已注册 | "邮箱已被注册" |
| 401 | Token 过期 | "Token 已过期" |
| 401 | Token 无效 | "Token 无效" |
| 403 | 主密码错误 | "主密码验证失败" |
| 404 | 用户不存在 | "用户不存在" |
| 404 | 密码条目不存在 | "密码条目不存在" |

---

## 安全机制

### 认证流程

```
┌─────────────────────────────────────────────────────────────┐
│                        双重验证                             │
│                                                             │
│  1. JWT Token 验证                                          │
│     └─→ 验证用户身份，确保已登录                            │
│                                                             │
│  2. 主密码验证 (敏感操作)                                   │
│     └─→ 验证操作权限，确保是账户所有者                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 密码安全

- 密码使用 Argon2id 哈希存储
- 密码派生使用 Argon2id + 盐
- 传输过程使用 HTTPS

### 数据加密

- 密码字段使用 AES-256-GCM 加密
- 加密密钥来自主密码派生
- 服务端无法获取明文密码

---

## 下一步

- 查看 [架构设计](../docs/architecture.md) 了解系统架构
- 查看 [开发指南](../docs/development.md) 了解开发调试
- 查看 [移动端设计](../docs/specs/mobile-design.md) 了解客户端实现
