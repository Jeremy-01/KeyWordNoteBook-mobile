# 密码本移动端迁移设计文档

**项目名称**: KeyWordNoteBook 移动端迁移
**版本**: v1.0.0
**日期**: 2026-05-10
**作者**: Y.MF
**状态**: 设计中

---

## 一、项目概述

### 1.1 背景与目标

当前 KeyWordNoteBook（密码本管理器）是一款基于 PyQt5 的桌面端应用，实现了安全的密码管理功能。为了扩展用户使用场景，计划迁移至移动端（iOS/Android），并引入账号系统和云端同步功能，实现多设备数据互通。

### 1.2 核心需求

| 需求类型 | 描述 |
|---------|------|
| 移动端支持 | 开发 iOS/Android 应用，使用 Flutter 框架 |
| 账号系统 | 支持用户注册、登录、密码找回 |
| 云端同步 | 密码本数据云端加密存储，多设备实时同步 |
| 生物识别 | 支持指纹/面容快速解锁 |
| 数据兼容 | 保留与桌面端数据格式的兼容性 |

### 1.3 技术选型

| 组件 | 技术方案 | 说明 |
|-----|---------|------|
| 移动端框架 | Flutter 3.x | 跨平台 iOS/Android |
| 后端 API | Python FastAPI | 复用 Core.py 加密逻辑 |
| 数据库 | PostgreSQL + Redis | PostgreSQL 存储用户数据，Redis 缓存 |
| 认证 | JWT + Refresh Token | 无状态认证 |
| 云存储 | S3/OBS 兼容对象存储 | 存储加密的密码本文件 |
| 生物识别 | flutter_local_auth | 系统级指纹/面容认证 |

---

## 二、系统架构

### 2.1 整体架构图

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              客户端层                                    │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐    │
│  │   桌面端 PyQt5   │  │ Android (Flutter)│  │   iOS (Flutter)   │    │
│  │   独立运行模式    │  │   在线同步模式    │  │   在线同步模式    │    │
│  │   本地文件存储    │  │   本地+云端存储   │  │   本地+云端存储   │    │
│  └────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘    │
│           │                       │                       │            │
└───────────┼───────────────────────┼───────────────────────┼────────────┘
            │                       │                       │
            ▼                       ▼                       ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                              API 网关层                                  │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                     Nginx / Caddy                                │   │
│  │  - SSL termination    - Load balancing    - Rate limiting       │   │
│  └──────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                              服务层                                      │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐      │
│  │   Auth Service    │  │  KeyBook API     │  │  Sync Service   │      │
│  │   用户认证服务     │  │  密码本CRUD API  │  │  数据同步服务    │      │
│  │   (FastAPI)       │  │  (FastAPI)       │  │  (FastAPI)       │      │
│  └────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘      │
│           │                       │                       │              │
│           └───────────────────────┼───────────────────────┘              │
│                                   │                                      │
└───────────────────────────────────┼──────────────────────────────────────┘
                                    │
         ┌──────────────────────────┼──────────────────────────┐
         │                          │                          │
         ▼                          ▼                          ▼
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│   PostgreSQL    │      │      Redis      │      │   对象存储 OSS   │
│   用户账号数据    │      │   会话/缓存      │      │  加密密码本文件  │
│   同步版本控制    │      │   分布式锁       │      │  附件存储        │
└─────────────────┘      └─────────────────┘      └─────────────────┘
```

### 2.2 数据流向

```
用户主密码（本地）
     │
     ├──► 派生 AES 密钥 ──► 加密本地密码本数据
     │                              │
     │                              ▼
     │                    ┌─────────────────┐
     │                    │  本地 SQLite     │  (离线可用)
     │                    │  (Flutter)        │
     │                    └────────┬─────────┘
     │                             │
     │              上传（加密数据）│  下载（加密数据）
     │                             │
     │                             ▼
     │                    ┌─────────────────┐
     └──► 派生 HMAC 密钥 ──►│  云端 OSS       │
                            │  (密文存储)     │
                            └─────────────────┘
```

---

## 三、API 接口设计

### 3.1 API 概览

| 模块 | 路径前缀 | 说明 |
|-----|---------|------|
| 认证 | `/api/v1/auth/*` | 注册、登录、Token 管理 |
| 密码本 | `/api/v1/keybook/*` | 密码条目 CRUD |
| 同步 | `/api/v1/sync/*` | 数据同步接口 |
| 用户 | `/api/v1/user/*` | 用户信息管理 |

### 3.2 认证模块 API

#### 3.2.1 用户注册

```
POST /api/v1/auth/register

Request:
{
    "email": "user@example.com",
    "password": "UserP@ss123",      // 主密码
    "password_confirm": "UserP@ss123"
}

Response (201):
{
    "code": 0,
    "message": "注册成功",
    "data": {
        "user_id": "usr_abc123",
        "email": "user@example.com",
        "created_at": "2026-05-10T10:00:00Z"
    }
}
```

#### 3.2.2 用户登录

```
POST /api/v1/auth/login

Request:
{
    "email": "user@example.com",
    "password": "UserP@ss123"
}

Response (200):
{
    "code": 0,
    "message": "登录成功",
    "data": {
        "access_token": "eyJhbGc...",
        "refresh_token": "eyJhbGc...",
        "expires_in": 3600,
        "token_type": "Bearer"
    }
}
```

#### 3.2.3 刷新 Token

```
POST /api/v1/auth/refresh

Request:
{
    "refresh_token": "eyJhbGc..."
}

Response (200):
{
    "code": 0,
    "data": {
        "access_token": "eyJhbGc...",
        "expires_in": 3600
    }
}
```

### 3.3 密码本模块 API

#### 3.3.1 获取密码本列表（非敏感字段）

```
GET /api/v1/keybook/items?page=1&page_size=20

Headers:
    Authorization: Bearer <access_token>

Response (200):
{
    "code": 0,
    "data": {
        "items": [
            {
                "index": "1",
                "url": "https://github.com",
                "username": "user@example.com",
                "password_level": 4,
                "link_url": "",
                "note": "GitHub 账号"
            }
        ],
        "total": 100,
        "page": 1,
        "page_size": 20
    }
}
```

#### 3.3.2 获取单个条目（解密后，需二次验证）

```
GET /api/v1/keybook/items/{item_id}

Headers:
    Authorization: Bearer <access_token>
    X-Verify-Password: <二次验证密码>

Response (200):
{
    "code": 0,
    "data": {
        "index": "1",
        "url": "https://github.com",
        "username": "user@example.com",
        "password": "decrypted_password",
        "password_level": 4,
        "link_url": "",
        "note": "GitHub 账号"
    }
}
```

#### 3.3.3 添加密码条目

```
POST /api/v1/keybook/items

Headers:
    Authorization: Bearer <access_token>
    X-Verify-Password: <二次验证密码>

Request:
{
    "url": "https://example.com",
    "username": "user@example.com",
    "password": "NewP@ss456",
    "link_url": "",
    "note": "Example 账号"
}

Response (201):
{
    "code": 0,
    "message": "添加成功",
    "data": {
        "index": "101"
    }
}
```

#### 3.3.4 更新密码条目

```
PUT /api/v1/keybook/items/{item_id}

Headers:
    Authorization: Bearer <access_token>
    X-Verify-Password: <二次验证密码>

Request:
{
    "url": "https://example.com",
    "username": "user@example.com",
    "password": "UpdatedP@ss789",
    "link_url": "",
    "note": "更新的备注"
}

Response (200):
{
    "code": 0,
    "message": "更新成功"
}
```

#### 3.3.5 删除密码条目

```
DELETE /api/v1/keybook/items/{item_id}

Headers:
    Authorization: Bearer <access_token>
    X-Verify-Password: <二次验证密码>

Response (200):
{
    "code": 0,
    "message": "删除成功"
}
```

### 3.4 同步模块 API

#### 3.4.1 获取同步状态

```
GET /api/v1/sync/status

Headers:
    Authorization: Bearer <access_token>

Response (200):
{
    "code": 0,
    "data": {
        "local_version": 5,
        "server_version": 5,
        "last_sync_time": "2026-05-10T09:30:00Z",
        "need_sync": false
    }
}
```

#### 3.4.2 执行同步（上传本地变更）

```
POST /api/v1/sync/push

Headers:
    Authorization: Bearer <access_token>

Request:
{
    "client_version": 5,
    "operations": [
        {
            "op": "update",
            "item_id": "1",
            "data": { ... }
        },
        {
            "op": "delete",
            "item_id": "3"
        }
    ]
}

Response (200):
{
    "code": 0,
    "data": {
        "server_version": 6,
        "conflicts": []
    }
}
```

#### 3.4.3 拉取服务端变更

```
POST /api/v1/sync/pull

Headers:
    Authorization: Bearer <access_token>

Request:
{
    "client_version": 5
}

Response (200):
{
    "code": 0,
    "data": {
        "server_version": 6,
        "operations": [...]
    }
}
```

### 3.5 错误码定义

| 错误码 | 说明 |
|-------|------|
| 0 | 成功 |
| 1001 | 参数错误 |
| 1002 | 认证失败 |
| 1003 | Token 过期 |
| 1004 | 权限不足 |
| 2001 | 资源不存在 |
| 2002 | 资源已存在 |
| 3001 | 同步冲突 |
| 5001 | 服务器内部错误 |

---

## 四、Flutter 移动端设计

### 4.1 项目结构

```
keybook_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── core/                          # 核心模块
│   │   ├── constants/
│   │   │   ├── app_constants.dart     # 应用常量
│   │   │   └── api_constants.dart     # API 地址
│   │   ├── crypto/
│   │   │   ├── crypto_service.dart    # 加密服务（复用 Core.py 逻辑）
│   │   │   └── key_derivation.dart    # 密钥派生
│   │   ├── network/
│   │   │   ├── api_client.dart        # HTTP 客户端
│   │   │   └── api_response.dart      # API 响应封装
│   │   └── storage/
│   │       ├── local_storage.dart     # 本地存储
│   │       └── secure_storage.dart    # 安全存储（Token）
│   │
│   ├── data/                          # 数据层
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── key_item_model.dart
│   │   │   └── sync_status_model.dart
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   └── keybook_repository.dart
│   │   └── providers/
│   │       ├── auth_provider.dart
│   │       └── keybook_provider.dart
│   │
│   ├── features/                      # 功能模块
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── widgets/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── item/
│   │   │   ├── item_list_screen.dart
│   │   │   ├── item_detail_screen.dart
│   │   │   └── item_edit_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   │
│   └── shared/                        # 共享组件
│       ├── widgets/
│       │   ├── app_button.dart
│       │   ├── app_text_field.dart
│       │   └── loading_overlay.dart
│       └── utils/
│           ├── validators.dart
│           └── formatters.dart
│
├── assets/
│   └── images/
│
├── pubspec.yaml
└── README.md
```

### 4.2 核心页面流程

```
启动
  │
  ▼
┌─────────────────┐
│  检查登录状态    │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌─────────┐  ┌─────────────────┐
│ 已登录  │  │   未登录/Token  │
└────┬────┘  │     过期        │
     │       └────────┬────────┘
     │                │
     │         ┌─────┴──────┐
     │         ▼            ▼
     │    ┌─────────┐  ┌────────────┐
     │    │  登录   │  │   注册     │
     │    │  页面   │  │   页面     │
     │    └────┬────┘  └─────┬──────┘
     │         │             │
     │         └──────┬──────┘
     │                ▼
     │       ┌─────────────────┐
     │       │  生物识别验证   │ (可选)
     │       └────────┬────────┘
     │                ▼
     │       ┌─────────────────┐
     │       │    主页面       │
     │       │  (密码列表)      │
     │       └────────┬────────┘
     │                │
     │       ┌────────┴────────┐
     │       ▼                ▼
     │  ┌──────────┐    ┌──────────┐
     │  │ 添加条目 │    │ 查看详情 │
     │  └──────────┘    └──────────┘
```

### 4.3 核心功能模块

#### 4.3.1 加密服务 (CryptoService)

```dart
/// 加密服务 - 封装密码本加密逻辑
/// 复用了 Core.py 中的 Argon2 + AES + HMAC 算法
class CryptoService {
  /// 使用 Argon2id 派生 AES 密钥
  Future<Uint8List> deriveAesKey(String masterKey, Uint8List salt);

  /// 使用 Argon2id 派生 HMAC 密钥
  Future<Uint8List> deriveHmacKey(String masterKey, Uint8List salt);

  /// AES 加密
  Future<String> encryptAes(String plaintext, Uint8List key);

  /// AES 解密
  Future<String> decryptAes(String ciphertext, Uint8List key);

  /// 计算 HMAC
  Future<String> computeHmac(Map<String, dynamic> data, Uint8List key);

  /// 验证 HMAC
  Future<bool> verifyHmac(Map<String, dynamic> data, String expectedHmac);
}
```

#### 4.3.2 生物识别服务 (BiometricService)

```dart
/// 生物识别服务
class BiometricService {
  /// 检查是否支持生物识别
  Future<bool> isSupported();

  /// 检查是否已设置生物识别
  Future<bool> isEnrolled();

  /// 认证
  Future<bool> authenticate({String reason = '验证身份'});

  /// 获取生物识别类型
  Future<BiometricType> getBiometricType();
}
```

#### 4.3.3 同步服务 (SyncService)

```dart
/// 同步服务
class SyncService {
  /// 同步状态
  final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>;

  /// 推送本地变更到服务器
  Future<SyncResult> pushChanges(List<SyncOperation> operations);

  /// 拉取服务器变更
  Future<SyncResult> pullChanges();

  /// 自动同步
  Future<void> autoSync();

  /// 解决冲突
  Future<void> resolveConflict(String itemId, ConflictResolution resolution);
}
```

### 4.4 状态管理 (Riverpod)

```dart
// 认证状态
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read);
});

// 密码本列表
final keybookProvider = StateNotifierProvider<KeybookNotifier, KeybookState>((ref) {
  return KeybookNotifier(ref.read);
});

// 同步状态
final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier(ref.read);
});

// 当前选中条目
final selectedItemProvider = StateProvider<KeyItem?>((ref) => null);
```

### 4.5 UI 设计要点

#### 主页面布局

```
┌─────────────────────────────────────┐
│  ▼ 密码本                    🔔  ⚙️  │  <- AppBar
├─────────────────────────────────────┤
│  🔍 搜索密码本...                    │  <- 搜索栏
├─────────────────────────────────────┤
│  ┌─────────────────────────────┐    │
│  │ 🌐 GitHub                   │    │
│  │    user@example.com         │    │  <- 密码卡片
│  │    ●●●●●●●●    [显示] [⋮]   │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ 🌐 Google                   │    │
│  │    gmail@gmail.com          │    │
│  │    ●●●●●●●●    [显示] [⋮]   │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ 🌐 Twitter                  │    │
│  │    @twitter_handle          │    │
│  │    ●●●●●●●●    [显示] [⋮]   │    │
│  └─────────────────────────────┘    │
│                                     │
│                              [＋]    │  <- 悬浮添加按钮
└─────────────────────────────────────┘
```

---

## 五、数据库设计

### 5.1 云端数据库 (PostgreSQL)

#### 用户表

```sql
CREATE TABLE users (
    id VARCHAR(32) PRIMARY KEY,           -- 用户ID，格式: usr_xxx
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,  -- Argon2 哈希
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    last_login_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_users_email ON users(email);
```

#### 密码本版本表

```sql
CREATE TABLE keybook_versions (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(32) NOT NULL REFERENCES users(id),
    version INTEGER NOT NULL DEFAULT 1,
    hmac_value VARCHAR(64) NOT NULL,      -- 完整性校验
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, version)
);

CREATE INDEX idx_keybook_versions_user ON keybook_versions(user_id);
```

#### 同步操作记录表

```sql
CREATE TABLE sync_operations (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(32) NOT NULL REFERENCES users(id),
    operation_id BIGSERIAL,
    item_id VARCHAR(32),
    operation_type VARCHAR(20) NOT NULL,   -- 'create', 'update', 'delete'
    operation_data JSONB,
    version INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),

    UNIQUE(user_id, operation_id)
);

CREATE INDEX idx_sync_ops_user ON sync_operations(user_id);
CREATE INDEX idx_sync_ops_version ON sync_operations(user_id, version);
```

### 5.2 本地数据库 (SQLite - Flutter)

```sql
CREATE TABLE key_items (
    index TEXT PRIMARY KEY,
    url TEXT NOT NULL,
    username TEXT NOT NULL,
    password_encrypted TEXT NOT NULL,
    password_level INTEGER DEFAULT 0,
    link_url TEXT,
    note TEXT,
    local_version INTEGER DEFAULT 0,
    sync_status TEXT DEFAULT 'synced',    -- 'synced', 'pending', 'conflict'
    created_at TEXT,
    updated_at TEXT
);

CREATE TABLE sync_metadata (
    key TEXT PRIMARY KEY,
    value TEXT
);

CREATE TABLE frequently_keys (
    index TEXT PRIMARY KEY,
    password_encrypted TEXT NOT NULL,
    password_level INTEGER,
    note TEXT
);
```

---

## 六、安全设计

### 6.1 密钥派生流程

```
用户主密码 (Master Key)
         │
         ├──► Argon2id(master_key, verify_salt) ──► verify_hash (存储)
         │
         ├──► Argon2id(master_key, encryption_salt) ──► AES-256 Key
         │
         └──► Argon2id(master_key, hmac_salt) ──► HMAC-SHA256 Key
```

### 6.2 数据加密流程

```
密码条目 (明文)
     │
     ├──► AES-256-GCM 加密 ──► encrypted_password
     │
     └──► HMAC-SHA256 签名 ──► hmac_value (用于完整性校验)
```

### 6.3 传输安全

| 安全措施 | 说明 |
|---------|------|
| HTTPS | 所有 API 强制使用 HTTPS |
| Token 时效 | Access Token 1小时，Refresh Token 7天 |
| 二次验证 | 查看/修改密码需输入主密码确认 |
| 生物识别 | 首次验证后可用指纹/面容快速解锁 |

---

## 七、同步机制

### 7.1 同步策略

```
┌─────────────────────────────────────────────────────────────┐
│                      同步流程                                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 启动时检查同步状态                                        │
│     ├── 获取本地版本号                                        │
│     ├── 获取服务端版本号                                      │
│     └── 比较判断是否需要同步                                   │
│                                                             │
│  2. 需要同步时                                               │
│     ├── 推送本地 pending 变更                                 │
│     ├── 拉取服务端新变更                                      │
│     └── 解决冲突                                             │
│                                                             │
│  3. 后台定时同步 (每5分钟)                                    │
│     ├── 检查服务端版本                                        │
│     └── 有更新则拉取                                          │
│                                                             │
│  4. 手动同步                                                 │
│     ├── 用户下拉刷新触发                                       │
│     └── 修改后自动触发                                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 7.2 冲突处理策略

| 冲突类型 | 处理策略 |
|---------|---------|
| 同一字段同时修改 | 以服务端时间戳为准，提示用户确认 |
| 本地新增，服务端已删除 | 保留本地版本 |
| 本地删除，服务端已修改 | 提示用户恢复或确认删除 |

---

## 八、实施计划

### 阶段一：后端 API 服务搭建 (预计 2 周)

| 任务 | 说明 | 优先级 |
|-----|------|-------|
| 项目初始化 | FastAPI 项目结构搭建 | P0 |
| 认证模块 | 用户注册、登录、Token 管理 | P0 |
| 数据库设计 | PostgreSQL 表结构设计 | P0 |
| OSS 集成 | 阿里云/腾讯云对象存储集成 | P1 |

### 阶段二：Flutter 移动端开发 (预计 3 周)

| 任务 | 说明 | 优先级 |
|-----|------|-------|
| 项目初始化 | Flutter 项目搭建、依赖安装 | P0 |
| 加密模块 | Dart 实现 Argon2、AES、HMAC | P0 |
| 认证模块 | 登录、注册、生物识别 | P0 |
| 密码列表 | 列表展示、搜索、添加 | P0 |
| 本地存储 | SQLite 数据持久化 | P0 |
| 同步模块 | 增量同步、冲突处理 | P1 |

### 阶段三：测试与优化 (预计 1 周)

| 任务 | 说明 | 优先级 |
|-----|------|-------|
| 单元测试 | 核心加密逻辑测试 | P0 |
| 集成测试 | API 接口测试 | P0 |
| 性能优化 | 大数据量加载优化 | P1 |
| 安全审计 | 加密安全性审查 | P0 |

---

## 九、依赖清单

### 9.1 Flutter 依赖

```yaml
dependencies:
  flutter:
    sdk: flutter

  # 状态管理
  flutter_riverpod: ^2.4.9

  # 网络
  dio: ^5.4.0

  # 本地存储
  sqflite: ^2.3.2
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2

  # 加密 (需要 Dart 实现 Argon2)
  pointycastle: ^3.7.4
  argon2: ^1.0.0
  cryptography: ^2.7.0

  # 生物识别
  local_auth: ^2.2.0

  # UI
  flutter_slidable: ^3.0.1

  # 工具
  intl: ^0.19.0
  uuid: ^4.3.3
  json_annotation: ^4.8.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
```

### 9.2 后端 Python 依赖

```
fastapi>=0.109.0
uvicorn[standard]>=0.27.0
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4
argon2-cffi>=23.1.0
cryptography>=43.0.0
asyncpg>=0.29.0
redis>=5.0.1
pydantic>=2.5.0
python-multipart>=0.0.6
boto3>=1.34.0
```

---

## 十、附录

### 10.1 数据格式 (与桌面端兼容)

密码本 JSON 格式保持与桌面端一致，确保未来数据互通：

```json
{
    "ARGON2_PARAMS": {
        "verify_hash": "$argon2id$...",
        "hash_len": 64,
        "encryption_salt": "base64...",
        "hmac_salt": "base64...",
        "hmac_key_encrypted": "base64...",
        "integrity_check": "sha256..."
    },
    "ItemList": {
        "1": {
            "Index": "1",
            "URL": "https://example.com",
            "UserName": "user@example.com",
            "Password": "encrypted...",
            "PasswordLevel": 4,
            "LinkURL": "",
            "Note": "备注"
        }
    },
    "FrequentlyKeys": {}
}
```

### 10.2 术语表

| 术语 | 说明 |
|-----|------|
| Master Key | 用户主密码 |
| AES-256 | 对称加密算法 |
| HMAC | 消息认证码 |
| Argon2id | 密码哈希算法 |
| JWT | JSON Web Token |
| OSS | 对象存储服务 |

---

**文档版本历史**

| 版本 | 日期 | 修改内容 |
|-----|------|---------|
| 1.0.0 | 2026-05-10 | 初始版本 |
