# KeyWordNoteBook API

后端 RESTful API 服务，为移动端提供认证、密码本管理和数据同步功能。

## 技术栈

- **框架**：FastAPI
- **数据库**：SQLite + SQLAlchemy ORM
- **认证**：JWT (HS256)
- **密码加密**：Argon2

## API 端点概览

| 模块 | 端点 | 方法 | 说明 |
|------|------|------|------|
| **认证** | `/api/v1/auth/register` | POST | 用户注册 |
| | `/api/v1/auth/login` | POST | 用户登录 |
| | `/api/v1/auth/refresh` | POST | 刷新令牌 |
| **密码本** | `/api/v1/keybook/items` | GET | 获取密码列表 |
| | `/api/v1/keybook/items/{id}` | GET | 获取密码详情 |
| | `/api/v1/keybook/items` | POST | 添加密码 |
| | `/api/v1/keybook/items/{id}` | PUT | 更新密码 |
| | `/api/v1/keybook/items/{id}` | DELETE | 删除密码 |
| **同步** | `/api/v1/sync/status` | GET | 获取同步状态 |
| | `/api/v1/sync/push` | POST | 推送本地变更 |
| | `/api/v1/sync/pull` | POST | 拉取服务端变更 |

## 认证机制

API 使用 JWT Bearer Token 认证。

### 注册流程

```
POST /api/v1/auth/register
{
  "email": "user@example.com",
  "master_password": "secure_password"
}
```

### 登录流程

```
POST /api/v1/auth/login
{
  "email": "user@example.com",
  "master_password": "secure_password"
}
```

响应：
```json
{
  "code": 0,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIs...",
    "expires_in": 3600
  }
}
```

### Token 使用

在请求头中携带：
```
Authorization: Bearer <access_token>
```

### 二次验证

获取密码详情、添加/修改/删除密码需要额外的 `master_pw` 验证：
```
X-Master-Password: <master_password>
```

## 数据模型

### 用户 (User)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 用户唯一标识 |
| email | String | 邮箱地址 |
| password_hash | String | Argon2 密码哈希 |
| created_at | DateTime | 创建时间 |

### 密码条目 (KeyBook)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 条目唯一标识 |
| user_id | UUID | 所属用户 |
| url | String | 网站/应用 URL |
| username | String | 用户名 |
| password_encrypted | String | AES-256 加密密码 |
| notes | String | 备注 |
| password_level | Integer | 密码强度等级 |
| created_at | DateTime | 创建时间 |
| updated_at | DateTime | 更新时间 |
| deleted_at | DateTime | 删除时间（软删除） |
| version | Integer | 版本号（乐观锁） |

### 同步操作 (SyncOperation)

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 操作唯一标识 |
| user_id | UUID | 用户 ID |
| operation_type | String | 操作类型 (CREATE/UPDATE/DELETE) |
| item_id | UUID | 关联的密码条目 |
| data | JSON | 操作数据 |
| created_at | DateTime | 操作时间 |
| synced | Boolean | 是否已同步 |

## 安全设计

### 密钥派生

使用 Argon2id 算法派生加密密钥：

```
Master Password
      │
      ├──► Argon2id ──► AES-256 Key (加密数据)
      │
      └──► Argon2id ──► HMAC-SHA256 Key (完整性校验)
```

### Argon2 参数

| 参数 | 值 | 说明 |
|------|------|------|
| memory_cost | 131072 KB | 内存消耗 |
| time_cost | 6 | 迭代次数 |
| parallelism | 6 | 并行线程数 |
| hash_len | 64 | 输出长度 |

## 同步机制

### 冲突解决策略

采用 Last-Write-Wins 策略，以 `updated_at` 时间戳为准。

### 同步流程

1. 客户端获取本地版本号
2. 请求 `/sync/status` 检查服务端版本
3. 如需同步，执行 `push` 或 `pull` 操作
4. 更新本地版本号

## 环境配置

```env
# 数据库
DATABASE_URL=sqlite:///./keybook.db

# JWT
JWT_SECRET_KEY=your-secret-key-change-in-production
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=60
REFRESH_TOKEN_EXPIRE_DAYS=7

# Argon2 (与桌面端保持一致)
ARGON2_MEMORY_COST=131072
ARGON2_TIME_COST=6
ARGON2_PARALLELISM=6

# 应用
DEBUG=True
```

## 运行服务

```bash
# 安装依赖
pip install -r requirements.txt

# 开发模式
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# 生产模式
uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 4
```

## API 文档

启动服务后访问：
- Swagger UI：http://localhost:8000/docs
- ReDoc：http://localhost:8000/redoc

## 模块结构

```
app/
├── main.py              # FastAPI 入口
├── api/v1/             # API 路由
│   ├── auth.py         # 认证接口
│   ├── keybook.py      # 密码本接口
│   └── sync.py         # 同步接口
├── core/               # 核心模块
│   ├── config.py       # 配置管理
│   ├── database.py     # 数据库连接
│   ├── deps.py         # 依赖注入
│   └── security.py     # 安全工具
├── models/             # 数据库模型
│   ├── user.py
│   └── keybook.py
├── schemas/            # Pydantic schemas
│   ├── auth.py
│   ├── keybook.py
│   └── common.py
└── services/           # 业务逻辑
    ├── auth_service.py
    ├── keybook_service.py
    └── sync_service.py
```
