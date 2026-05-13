# 开发指南

本指南帮助开发者搭建本地开发环境，理解项目结构，并掌握日常开发流程。

## 目录

- [环境准备](#环境准备)
- [项目结构](#项目结构)
- [移动端开发](#移动端开发)
- [后端开发](#后端开发)
- [联合调试](#联合调试)
- [调试技巧](#调试技巧)
- [常见问题](#常见问题)

---

## 环境准备

### 1. 安装 Git

```bash
# macOS (使用 Homebrew)
brew install git

# Ubuntu/Debian
sudo apt update && sudo apt install git

# Windows
# 下载安装包: https://git-scm.com/download/win
```

### 2. 安装 Flutter SDK

#### macOS

```bash
# 使用 Homebrew
brew install flutter

# 或手动安装
# 1. 下载: https://docs.flutter.dev/get-started/install/macos
# 2. 解压到 ~/development/flutter
# 3. 添加到 PATH: export PATH="$PATH:$HOME/development/flutter/bin"
```

#### Linux

```bash
# 安装依赖
sudo apt update
sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev

# 下载并解压 Flutter SDK
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar xf flutter_linux_3.24.0-stable.tar.xz

# 添加到 PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

#### Windows

1. 下载 Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. 解压到 `C:\src\flutter`
3. 在系统环境变量中添加 `C:\src\flutter\bin`

### 3. 安装 Python

```bash
# macOS (使用 Homebrew)
brew install python@3.11

# Ubuntu/Debian
sudo apt install python3.11 python3.11-venv python3.11-dev

# Windows
# 下载: https://www.python.org/downloads/
# 安装时勾选 "Add Python to PATH"
```

### 4. 安装 IDE

**推荐: VS Code**

| 插件 | 用途 |
|------|------|
| Flutter | Flutter 支持 |
| Dart | Dart 语言支持 |
| Python | Python 语言支持 |
| Pylance | Python 类型检查 |
| REST Client | API 测试 |

**备选: Android Studio / IntelliJ IDEA**

- Flutter 插件
- Python 插件

### 5. 验证安装

```bash
# Flutter
flutter --version
flutter doctor

# Python
python --version
pip --version

# Git
git --version
```

---

## 项目结构

```
KeyWordNoteBook/
├── mobile/                    # Flutter 移动端
│   ├── lib/
│   │   ├── core/             # 核心服务
│   │   │   ├── biometric/     # 生物识别
│   │   │   ├── constants/     # 常量配置
│   │   │   ├── crypto/        # 加密服务
│   │   │   ├── network/      # API 客户端
│   │   │   ├── storage/      # 本地存储
│   │   │   └── sync/         # 同步服务
│   │   ├── data/             # 数据层
│   │   │   ├── models/       # 数据模型
│   │   │   ├── repositories/ # 数据仓库
│   │   │   └── providers/    # 状态管理
│   │   ├── features/         # 业务功能
│   │   │   ├── auth/         # 认证模块
│   │   │   ├── home/         # 主页
│   │   │   ├── item/         # 密码条目
│   │   │   └── settings/     # 设置
│   │   └── shared/           # 共享组件
│   └── test/                 # 测试文件
│
├── server/                    # FastAPI 后端
│   ├── app/
│   │   ├── api/v1/          # API 路由
│   │   ├── core/            # 核心配置
│   │   ├── models/          # 数据库模型
│   │   ├── schemas/         # 数据校验
│   │   └── services/        # 业务逻辑
│   └── requirements.txt     # Python 依赖
│
├── docs/                     # 文档
│   ├── README.md            # 文档索引
│   ├── development.md       # 本文件
│   ├── architecture.md     # 架构设计
│   └── specs/              # 设计规范
│
├── CONTRIBUTING.md          # 贡献指南
└── README.md                # 项目概览
```

---

## 移动端开发

### 安装依赖

```bash
cd mobile
flutter pub get
```

### 运行应用

```bash
# 开发模式（热重载）
flutter run

# 指定设备
flutter run -d <device_id>

# 查看可用设备
flutter devices
```

### 项目结构详解

#### 核心模块 (`lib/core/`)

**biometric/**
- `biometric_service.dart`: 生物识别认证服务
- 支持指纹和面容识别
- 提供快速解锁功能

**crypto/**
- `crypto_service.dart`: 加密服务入口
- `aes_encryption.dart`: AES-256-GCM 加密实现
- `key_derivation.dart`: Argon2 密钥派生
- `password_strength.dart`: 密码强度评估
- `hmac_util.dart`: HMAC 签名工具

**network/**
- `api_client.dart`: Dio HTTP 客户端封装
- `token_manager.dart`: JWT Token 管理
- `api_exception.dart`: API 异常处理
- `api_response.dart`: 统一响应格式

**storage/**
- `local_storage.dart`: SQLite 数据库封装
- `key_item.dart`: 密码条目数据模型
- `pending_operation.dart`: 待同步操作队列

**sync/**
- `sync_service.dart`: 同步服务
- `sync_state.dart`: 同步状态管理
- `sync_conflict_resolver.dart`: 冲突解决策略

#### 数据层 (`lib/data/`)

**models/**
- `auth_models.dart`: 认证相关模型
- `key_item_model.dart`: 密码条目模型
- `sync_models.dart`: 同步相关模型

**providers/**
- `auth_provider.dart`: 认证状态管理
- `keybook_provider.dart`: 密码本状态管理
- `settings_provider.dart`: 设置状态管理

**repositories/**
- `auth_repository.dart`: 认证数据仓库
- `keybook_repository.dart`: 密码本数据仓库

#### 功能模块 (`lib/features/`)

**auth/**
- `login_screen.dart`: 登录界面
- `register_screen.dart`: 注册界面

**home/**
- `home_screen.dart`: 密码列表主页
- 支持搜索和过滤

**item/**
- `item_detail_screen.dart`: 密码详情
- `item_edit_screen.dart`: 密码编辑/新建

**settings/**
- `settings_screen.dart`: 设置界面
- 生物识别开关
- 同步设置
- 安全设置

### 测试

```bash
cd mobile

# 运行所有测试
flutter test

# 运行特定模块
flutter test test/core/crypto_service_test.dart
flutter test test/core/sync_test.dart

# 检查代码质量
flutter analyze
flutter format .
```

### 构建发布

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (需要 macOS 和 Xcode)
flutter build ios --release

# Web
flutter build web
```

---

## 后端开发

### 虚拟环境

```bash
cd server

# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
# Linux/macOS
source venv/bin/activate

# Windows
venv\Scripts\activate

# 验证激活
which python  # Linux/macOS
where python  # Windows
```

### 安装依赖

```bash
pip install -r requirements.txt
```

### 环境变量

```bash
# 复制配置模板
cp .env.example .env

# 编辑配置
cat .env
```

**配置说明**:

| 变量 | 说明 | 默认值 |
|------|------|-------|
| `DATABASE_URL` | 数据库连接 | `sqlite:///./keybook.db` |
| `JWT_SECRET_KEY` | JWT 密钥 | `your-secret-key` |
| `DEBUG` | 调试模式 | `True` |
| `JWT_ALGORITHM` | JWT 算法 | `HS256` |

### 运行服务

```bash
# 开发模式（热重载）
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# 生产模式
uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 4

# 指定环境变量文件
uvicorn app.main:app --reload --env-file .env
```

### API 文档

启动服务后访问：
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

### 项目结构详解

#### API 路由 (`app/api/v1/`)

**auth.py**
- `POST /auth/register`: 用户注册
- `POST /auth/login`: 用户登录
- `POST /auth/refresh`: 刷新 Token

**keybook.py**
- `GET /keybook/items`: 获取密码列表
- `GET /keybook/items/{id}`: 获取密码详情
- `POST /keybook/items`: 添加密码
- `PUT /keybook/items/{id}`: 更新密码
- `DELETE /keybook/items/{id}`: 删除密码

**sync.py**
- `GET /sync/status`: 获取同步状态
- `POST /sync/push`: 推送本地变更
- `POST /sync/pull`: 拉取服务端变更

#### 核心模块 (`app/core/`)

**config.py**: 应用配置管理
**database.py**: 数据库连接和初始化
**deps.py**: 依赖注入
**security.py**: 安全工具函数

#### 服务层 (`app/services/`)

**auth_service.py**: 认证逻辑
**keybook_service.py**: 密码本业务逻辑
**sync_service.py**: 同步业务逻辑

### 测试

```bash
cd server

# 运行所有测试
pytest

# 运行特定测试
pytest tests/test_auth.py

# 带覆盖率
pytest --cov=app --cov-report=html

# 查看覆盖率报告
open htmlcov/index.html  # macOS
xdg-open htmlcov/index.html  # Linux
```

---

## 联合调试

### 启动后端服务

```bash
cd server
source venv/bin/activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 启动移动端

```bash
cd mobile
flutter run
```

### 调试配置

#### VS Code 调试配置

创建 `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Mobile)",
      "type": "dart",
      "request": "launch",
      "program": "mobile/lib/main.dart",
      "cwd": "${workspaceFolder}"
    },
    {
      "name": "Python (Backend)",
      "type": "python",
      "request": "launch",
      "module": "uvicorn",
      "args": [
        "app.main:app",
        "--reload",
        "--host",
        "0.0.0.0",
        "--port",
        "8000"
      ],
      "cwd": "${workspaceFolder}/server",
      "env": {
        "PYTHONPATH": "${workspaceFolder}/server"
      }
    }
  ]
}
```

#### 修改移动端 API 地址

移动端默认 API 地址在 `mobile/lib/core/constants/app_constants.dart` 中定义为 `http://localhost:8000/api/v1`。
开发时推荐通过 `--dart-define` 覆盖，而不是直接改源码:

```bash
# Android 模拟器
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1

# Android 真机（USB）
adb reverse tcp:8000 tcp:8000
flutter run

# Android 真机（局域网）
flutter run --dart-define=API_BASE_URL=http://<你的电脑局域网IP>:8000/api/v1
```

---

## 调试技巧

### Flutter 调试

**热重载**: 在运行状态下按 `r` 键

**热重启**: 按 `R` 键

**调试菜单**: 按 `d` 键打开 Flutter DevTools

**打印日志**:
```dart
import 'dart:developer' as developer;

developer.log('Debug info', name: 'MyApp');
```

**检查 Widget**:
```dart
// 在需要检查的 Widget 外包裹
debugPaintBaselinesEnabled = true;
```

### Python 调试

**使用 pdb**:
```python
import pdb
pdb.set_trace()
```

**使用 ipdb** (更好的体验):
```python
import ipdb
ipdb.set_trace()
```

**打印日志**:
```python
import logging
logger = logging.getLogger(__name__)
logger.debug("Debug info")
```

### API 测试

使用 Swagger UI (http://localhost:8000/docs):

1. 先调用 `/auth/register` 注册用户
2. 调用 `/auth/login` 获取 Token
3. 点击右上角 **Authorize** 按钮
4. 输入 Token
5. 测试其他接口

### 近期踩坑记录

以下问题都在本项目中实际踩过，并已经通过测试或真机回归验证过。后续遇到相似现象时，优先按这里排查，不要重复走弯路。

#### 1. Flutter 命令必须从 `mobile/` 目录执行

仓库根目录同时包含 `mobile/` 和 `server/`，不是 Flutter 项目根。

```bash
cd mobile
flutter pub get
flutter test
flutter run
```

如果在仓库根目录直接执行 Flutter 命令，常见结果是找不到 `pubspec.yaml`，或者命令行为与预期不一致。

#### 2. 真机 USB 调试优先走仓库脚本

Android 真机联调时，推荐使用仓库内脚本或 VS Code 任务，而不是每次手动执行 `adb reverse`。

```bash
# 仅准备 USB 端口转发
bash scripts/run-mobile-android-usb.sh --prepare-only

# 准备后直接运行移动端
bash scripts/run-mobile-android-usb.sh
```

这样可以避免忘记端口转发，导致移动端连不上本地 `http://localhost:8000/api/v1`。

#### 3. `flutter clean` 后不要直接依赖 `flutter install --debug`

本项目里已经遇到过：

```bash
flutter clean
flutter install --debug -d <device>
```

执行后并不会自动重新生成 `build/app/outputs/flutter-apk/app-debug.apk`，从而安装失败。

更稳妥的做法是显式先构建，再安装：

```bash
flutter build apk --debug
flutter install --use-application-binary build/app/outputs/flutter-apk/app-debug.apk -d <device>
```

做真机回归时，优先使用这套命令。

#### 4. Android 真机上的退出登录，不要依赖裸坐标点击弹窗

设置页旧版退出确认是 Flutter `AlertDialog`。在 Xiaomi / Android 16 真机上，设备 XML 会暴露一个全屏 `Dismiss` 语义节点，导致 `adb shell input tap` 或按坐标点击经常被遮罩层吞掉，看起来像“按钮点了没反应”。

排查这类问题时：

- 优先用 `adb exec-out screencap -p` 看真实画面。
- 用 `uiautomator dump` 校准控件 bounds 和语义节点，不要只猜坐标。
- 真机自动化优先走仓库脚本 `scripts/run-mobile-android-uiautomator.sh`，而不是手工 tap。

#### 5. 退出登录后的导航问题，根因不在按钮，而在根路由栈

之前“从首页进入设置，再退出登录没有真正回到登录页”的问题，根因不是 `logout()` 接口，也不是按钮点击失败，而是认证前后共用了同一个根 `navigatorKey`。这样即使 `home:` 已经切回登录页，旧的受保护路由栈仍可能残留。

修复思路是：

- 认证态和未认证态使用不同的根 `navigatorKey`
- 在认证状态切换时直接切换整棵根导航树

如果后续又出现“UI 看似退出了，但返回键还能回到受保护页面”，先检查根导航树是否真正随认证态重建。

#### 6. 自动锁定会污染真机调试结果

`SettingsProvider` 默认 `autoLockMinutes = 1`。做较长时间的真机设置页或退出登录回归时，如果不先把自动锁定改长，稍微停顿就会被锁屏浮层覆盖，造成误判，看起来像“设置页点不动”“右上角按钮失效”或“自动化脚本失灵”。

做长链路真机回归前，建议先在应用里把自动锁定切到 15 分钟。

#### 7. 锁屏页才是当前剩余 overflow 的真实来源，不是登录页/注册页

曾经怀疑登录页和注册页仍有键盘弹出后的 overflow，但专项测试已经证明这两个页面在 `390x780 + viewInsets.bottom = 320` 场景下是稳定的。

真正仍会溢出的页面是锁屏页手动解锁面板：原布局是固定高度的 `Center + Column`，在键盘弹出后会触发 `RenderFlex overflowed by 101 pixels on the bottom`。

稳定方案是比照首页骨架，把顶层改成可滚动结构：

- `CustomScrollView`
- `ScrollViewKeyboardDismissBehavior.onDrag`
- `SliverFillRemaining(hasScrollBody: false)`
- 内容区用 `ConstrainedBox(maxWidth: 520)` 保持大屏居中

遇到类似“平时正常、键盘弹出就 overflow”的页面，优先先看顶层是否仍是固定高度 `Column`，而不是先改内部间距。

#### 8. 后端本地启动依赖 `server/.env`

本地直接启动后端前，先确认 `server/.env` 存在且配置完整。否则可能落回 `DEBUG=False` 的默认路径，并因为缺少 `JWT_SECRET_KEY` 被配置校验拦下。

如果出现本地后端启动失败、但 Python 环境本身没问题，先检查 `.env`，再去怀疑解释器或依赖。

---

## 常见问题

### Flutter 问题

**Q: `flutter pub get` 失败**
```
A: 检查网络连接，尝试使用代理:
   export https_proxy=http://proxy:port
   flutter pub get
```

**Q: Android 模拟器无法启动**
```
A: 确保已安装 Android SDK:
   flutter doctor -v
   按提示安装缺失组件
```

**Q: 热重载不生效**
```
A: 有些改动需要热重启 (按 R):
   - 修改 main() 函数
   - 修改静态变量
```

### 后端问题

**Q: `uvicorn` 命令未找到**
```
A: 确保已激活虚拟环境:
   source venv/bin/activate
```

**Q: 数据库连接失败**
```
A: 检查 DATABASE_URL 配置和数据库文件权限
```

**Q: Token 过期**
```
A: 刷新 Token 或重新登录
```

### 调试工具推荐

| 工具 | 用途 |
|------|------|
| Flutter DevTools | Flutter UI 检查和性能分析 |
| Postman/Insomnia | API 测试 |
| Charles/Fiddler | 网络抓包 |
| SQLite Browser | 数据库查看 |

---

## 下一步

- 查看 [架构设计](architecture.md) 了解系统设计
- 查看 [移动端设计](specs/mobile-design.md) 了解移动端实现
- 阅读 [贡献指南](../CONTRIBUTING.md) 了解提 PR 流程
