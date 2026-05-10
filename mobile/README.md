# KeyWordNoteBook 移动端

密码本管理器的 Flutter 移动端应用。

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
│   ├── crypto/     # 加密服务
│   ├── network/    # API 客户端
│   └── constants/  # 常量配置
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

## 许可证

MIT License
