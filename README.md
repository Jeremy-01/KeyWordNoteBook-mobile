# KeyWordNoteBook

密码本管理器 - 支持 Flutter 移动端和 FastAPI 后端服务。

## 功能特性

- 🔐 安全的密码管理
- 🔑 AES-256-GCM 端到端加密
- 👆 指纹/面容快速解锁
- 🔄 云端同步（待实现）
- 📱 iOS/Android 双平台支持

## 技术栈

- Flutter 3.x
- Riverpod 状态管理
- Dio HTTP 客户端
- SQLite 本地存储
- flutter_secure_storage

## 开始使用

### 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0

### 安装依赖

```bash
cd mobile
flutter pub get
```

### 运行应用

```bash
flutter run
```

### 构建发布

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 项目结构

```
lib/
├── core/           # 核心模块
│   ├── biometric/ # 生物识别服务
│   ├── crypto/    # 加密服务
│   ├── network/   # API 客户端
│   ├── storage/   # 本地存储 (SQLite)
│   └── constants/ # 常量配置
├── data/           # 数据层
│   ├── models/     # 数据模型
│   ├── repositories/ # 仓库层
│   └── providers/   # 状态管理
├── features/       # 功能模块
│   ├── auth/       # 认证
│   ├── home/       # 主页
│   ├── item/       # 密码条目
│   └── settings/   # 设置
└── shared/         # 共享组件
```

## 开发指南

### TDD 测试驱动开发

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/core/local_storage_test.dart
flutter test test/core/biometric_test.dart
```

### 模块说明

- **LocalStorage**: SQLite 数据库封装，支持密码条目 CRUD、同步状态管理、待同步队列
- **BiometricService**: 生物识别认证，支持指纹/面容识别、自定义认证选项

## 许可证

MIT License
