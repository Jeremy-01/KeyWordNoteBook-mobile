# KeyWordNoteBook

安全的密码本管理器，为你的数字生活保驾护航。

KeyWordNoteBook 是一款开源的跨平台密码管理应用，采用端到端加密技术，确保你的密码安全存储和同步。支持 iOS、Android 和 Web 平台。

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 🔐 **端到端加密** | AES-256-GCM + Argon2 密钥派生，即使服务器被攻破也无法解密 |
| 👆 **生物识别** | 支持指纹和面容识别，快速安全解锁 |
| ☁️ **云端同步** | 多设备实时同步，支持离线使用 |
| 📱 **跨平台** | iOS、Android 双平台支持 |
| 🎯 **密码强度** | 实时评估密码强度，保护账户安全 |

## 🚀 快速开始

### 前置要求

| 组件 | 最低版本 | 安装指南 |
|------|---------|---------|
| Flutter SDK | >= 3.0.0 | [Flutter 官网](https://flutter.dev/docs/get-started/install) |
| Python | >= 3.9 | [Python 官网](https://www.python.org/downloads/) |
| Git | 最新版本 | [Git 官网](https://git-scm.com/downloads) |

### 1. 克隆项目

```bash
git clone https://github.com/Jeremy-01/KeyWordNoteBook.git
cd KeyWordNoteBook
```

### 2. 启动后端服务

```bash
cd server

# 创建虚拟环境（推荐）
python -m venv venv
source venv/bin/activate  # Linux/macOS
# venv\Scripts\activate  # Windows

# 安装依赖
pip install -r requirements.txt

# 复制环境变量
cp .env.example .env

# 启动服务
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

后端启动成功后，访问 http://localhost:8000/docs 查看 API 文档。

### 3. 启动移动端

```bash
# 新开终端
cd mobile

# 安装依赖
flutter pub get

# 运行应用
flutter run
```

> **提示**: 如果使用 Android 模拟器访问本地后端，API 地址使用 `http://10.0.2.2:8000`

### 4. 开始使用

1. 打开应用，点击 **注册** 创建账户
2. 输入邮箱和主密码
3. 主密码是你所有密码的"密码之母"，请务必记住
4. 注册成功后即可开始添加密码条目

## 📖 文档导航

本项目提供完善的文档支持：

| 文档 | 内容 |
|------|------|
| [📖 项目概览](README.md) | 项目介绍、功能特性 |
| [👨‍💻 贡献指南](CONTRIBUTING.md) | 如何参与开发、代码规范、提 PR 流程 |
| [🔧 开发指南](docs/development.md) | 环境搭建、开发调试、测试运行 |
| [🏗️ 架构设计](docs/architecture.md) | 系统架构、技术选型、设计决策 |
| [📱 移动端设计](docs/specs/mobile-design.md) | 移动端实现细节 |
| [⚙️ 后端 API](server/README.md) | API 端点、数据模型 |

**推荐阅读顺序**（新贡献者）：

```
1. 项目概览 (README.md)      → 了解项目是什么
2. 架构设计 (docs/architecture.md) → 了解怎么设计
3. 开发指南 (docs/development.md)  → 了解怎么开发
4. 贡献指南 (CONTRIBUTING.md)     → 了解怎么贡献
```

## 🛠️ 技术栈

### 移动端

```
Flutter 3.x
├── 状态管理: Riverpod
├── HTTP 客户端: Dio
├── 本地存储: SQLite + flutter_secure_storage
├── 生物识别: local_auth
└── 加密: PointyCastle (AES-256-GCM, Argon2)
```

### 后端

```
Python 3.9+
├── Web 框架: FastAPI
├── ORM: SQLAlchemy
├── 数据库: SQLite
├── 认证: JWT (PyJWT)
├── 密码哈希: Argon2 (argon2-cffi)
└── 数据验证: Pydantic
```

## 📁 项目结构

```
KeyWordNoteBook/
│
├── mobile/                      # Flutter 移动端
│   ├── lib/
│   │   ├── core/              # 核心服务
│   │   │   ├── crypto/        # 加密服务
│   │   │   ├── network/      # API 客户端
│   │   │   ├── storage/      # 本地存储
│   │   │   ├── sync/         # 同步服务
│   │   │   └── biometric/     # 生物识别
│   │   ├── data/             # 数据层
│   │   │   ├── models/       # 数据模型
│   │   │   ├── repositories/ # 数据仓库
│   │   │   └── providers/    # 状态管理
│   │   └── features/         # 功能模块
│   │       ├── auth/         # 认证
│   │       ├── home/         # 主页
│   │       ├── item/          # 密码条目
│   │       └── settings/      # 设置
│   └── test/                  # 单元测试
│
├── server/                     # FastAPI 后端
│   └── app/
│       ├── api/v1/           # API 路由
│       ├── core/             # 核心配置
│       ├── models/           # 数据库模型
│       ├── schemas/          # 数据校验
│       └── services/         # 业务逻辑
│
├── docs/                      # 文档
│   ├── README.md             # 文档索引
│   ├── development.md       # 开发指南
│   ├── architecture.md       # 架构设计
│   └── specs/
│       └── mobile-design.md  # 移动端设计
│
├── CONTRIBUTING.md           # 贡献指南
└── README.md                 # 本文件
```

## 🔒 安全设计

### 密钥派生

```
主密码 (Master Password)
    │
    ├─→ Argon2id ──→ AES-256 加密密钥
    │
    └─→ Argon2id ──→ HMAC 签名密钥
```

### 安全措施

- **本地加密**: 所有敏感数据使用 AES-256-GCM 加密
- **密钥隔离**: 加密密钥存储在系统安全区域 (Keychain/Keystore)
- **双重验证**: 敏感操作需要 JWT Token + 主密码双重验证
- **自动锁定**: 可配置无操作后自动锁定应用

## 🧪 测试

### 移动端测试

```bash
cd mobile

# 运行所有测试
flutter test

# 运行特定模块测试
flutter test test/core/crypto_service_test.dart
flutter test test/core/sync_test.dart

# 代码质量检查
flutter analyze
```

### 后端测试

```bash
cd server

# 运行所有测试
pytest

# 带覆盖率报告
pytest --cov=app --cov-report=html

# 查看报告
open htmlcov/index.html  # macOS
xdg-open htmlcov/index.html  # Linux
```

## 🤝 贡献

欢迎任何形式的贡献！请查看 [贡献指南](CONTRIBUTING.md) 了解：

- 如何 Fork 和 Clone 项目
- 开发环境配置
- 代码规范和提交格式
- Pull Request 流程

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [Flutter](https://flutter.dev/) - 跨平台 UI 框架
- [FastAPI](https://fastapi.tiangolo.com/) - 现代 Python Web 框架
- [Argon2](https://github.com/p-h-c/phc-winner-argon2) - 密码哈希竞赛冠军
- 所有开源库的贡献者

---

如果你觉得这个项目有帮助，请给一个 ⭐！
