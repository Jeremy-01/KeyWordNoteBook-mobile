# KeyWordNoteBook

安全的密码本管理器，支持 Flutter 移动端和 FastAPI 后端服务，提供端到端加密和云端同步功能。

## 功能特性

- **端到端加密**：AES-256-GCM + Argon2 密钥派生
- **生物识别**：指纹/面容快速解锁
- **云端同步**：多设备实时同步，支持冲突解决
- **跨平台**：iOS/Android 双平台支持

## 技术栈

### 移动端 (mobile/)

- Flutter 3.x + Dart
- Riverpod 状态管理
- Dio HTTP 客户端
- SQLite + flutter_secure_storage 本地存储
- local_auth 生物识别

### 后端服务 (server/)

- FastAPI + Python 3.x
- SQLAlchemy ORM
- SQLite 数据库
- JWT 认证

## 快速开始

### 前置条件

- Flutter SDK >= 3.0.0
- Python 3.9+
- Git

### 克隆项目

```bash
git clone https://github.com/Jeremy-01/KeyWordNoteBook.git
cd KeyWordNoteBook
```

### 启动后端服务

```bash
cd server
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

服务将在 http://localhost:8000 启动，API 文档：http://localhost:8000/docs

### 启动移动端

```bash
cd mobile
flutter pub get
flutter run
```

## 项目结构

```
KeyWordNoteBook/
├── mobile/                      # Flutter 移动端
│   ├── lib/
│   │   ├── core/               # 核心模块
│   │   │   ├── biometric/      # 生物识别服务
│   │   │   ├── constants/      # 常量配置
│   │   │   ├── crypto/        # AES-256 加密服务
│   │   │   ├── network/        # API 客户端
│   │   │   ├── storage/        # SQLite 本地存储
│   │   │   └── sync/           # 云端同步服务
│   │   ├── data/               # 数据层
│   │   │   ├── models/         # 数据模型
│   │   │   ├── repositories/   # 仓库层
│   │   │   └── providers/      # Riverpod 状态管理
│   │   ├── features/           # 功能模块
│   │   │   ├── auth/           # 登录/注册
│   │   │   ├── home/           # 密码列表
│   │   │   ├── item/           # 密码详情/编辑
│   │   │   └── settings/       # 设置
│   │   └── shared/             # 共享组件
│   └── test/                   # 单元测试
│
├── server/                      # FastAPI 后端
│   └── app/
│       ├── api/v1/             # API 路由
│       ├── core/               # 核心配置
│       ├── models/             # 数据库模型
│       ├── schemas/            # Pydantic schemas
│       └── services/           # 业务逻辑
│
├── docs/
│   └── specs/                  # 设计文档
│       └── mobile-design.md    # 移动端迁移设计
│
└── README.md                   # 本文件
```

## 开发指南

### 移动端测试

```bash
cd mobile
flutter test                    # 运行所有测试
flutter test test/core/        # 运行核心模块测试
```

### 后端测试

```bash
cd server
pytest                         # 运行所有测试
```

### 环境变量

**后端 (server/.env)**
```env
DATABASE_URL=sqlite:///./keybook.db
JWT_SECRET_KEY=your-secret-key
DEBUG=True
```

**移动端 (mobile/.env.example)**
```env
API_BASE_URL=http://localhost:8000
```

## 文档维护

本项目采用增量更新策略，文档随代码同步维护。

**更新规则：**
- 新增功能 → 更新对应模块 README 和设计文档
- API 变更 → 更新 server/README.md 和 API 文档
- 重大重构 → 更新 docs/specs/ 设计文档

**文档位置：**
- 项目概览 → 根目录 README.md
- 后端服务 → server/README.md
- 设计规范 → docs/specs/

## 许可证

MIT License
