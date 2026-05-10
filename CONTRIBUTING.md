# 贡献指南

感谢你考虑为 KeyWordNoteBook 做出贡献！本指南将帮助你了解如何参与项目开发。

## 目录

- [快速开始](#快速开始)
- [开发环境](#开发环境)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [提交规范](#提交规范)
- [测试指南](#测试指南)
- [ Pull Request 流程](#pull-request-流程)
- [社区准则](#社区准则)

---

## 快速开始

### 1. Fork 项目

访问 [KeyWordNoteBook](https://github.com/Jeremy-01/KeyWordNoteBook) 仓库，点击右上角 **Fork** 按钮。

### 2. 克隆你的 Fork

```bash
# 替换为你自己的 GitHub 用户名
git clone https://github.com/YOUR_USERNAME/KeyWordNoteBook.git
cd KeyWordNoteBook
```

### 3. 添加上游仓库

```bash
git remote add upstream https://github.com/Jeremy-01/KeyWordNoteBook.git
```

### 4. 创建功能分支

```bash
git checkout -b feature/your-feature-name
# 或修复 bug
git checkout -b fix/issue-description
```

---

## 开发环境

### 前置要求

| 组件 | 要求 | 验证命令 |
|------|------|---------|
| Flutter SDK | >= 3.0.0 | `flutter --version` |
| Dart SDK | >= 3.0.0 | `dart --version` |
| Python | >= 3.9 | `python --version` |
| Git | 最新版本 | `git --version` |

### 移动端环境

```bash
cd mobile

# 安装依赖
flutter pub get

# 运行应用
flutter run
```

### 后端环境

```bash
cd server

# 创建虚拟环境（推荐）
python -m venv venv
source venv/bin/activate  # Linux/Mac
# 或 venv\Scripts\activate  # Windows

# 安装依赖
pip install -r requirements.txt

# 运行服务
uvicorn app.main:app --reload
```

### 环境变量配置

**后端环境变量** (`server/.env`):

```env
# 复制示例配置
cp .env.example .env

# 编辑配置
DATABASE_URL=sqlite:///./keybook.db
JWT_SECRET_KEY=your-secret-key-change-in-production
DEBUG=True
```

**移动端环境变量** (`mobile/.env`):

```env
API_BASE_URL=http://localhost:8000
```

---

## 开发流程

### 分支命名规范

| 类型 | 命名格式 | 示例 |
|------|---------|------|
| 功能分支 | `feature/<功能描述>` | `feature/password-generator` |
| 修复分支 | `fix/<问题描述>` | `fix/biometric-timeout` |
| 重构分支 | `refactor/<范围>` | `refactor/crypto-module` |
| 文档分支 | `docs/<文档类型>` | `docs/api-documentation` |
| 实验分支 | `experiment/<实验名>` | `experiment/offline-mode` |

### 开发步骤

1. **同步上游代码**
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **创建功能分支**
   ```bash
   git checkout -b feature/your-feature
   ```

3. **编写代码** - 遵循代码规范

4. **运行测试** - 确保所有测试通过
   ```bash
   # 移动端
   cd mobile && flutter test

   # 后端
   cd server && pytest
   ```

5. **提交代码** - 使用规范的提交信息

6. **推送分支**
   ```bash
   git push origin feature/your-feature
   ```

7. **创建 Pull Request**

---

## 代码规范

### Flutter/Dart 规范

- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 风格指南
- 使用 `flutter analyze` 检查代码
- 所有公开 API 必须有文档注释
- 单元测试覆盖率 >= 80%

**代码格式**:
```bash
cd mobile
flutter format .
dart analyze .
```

**Import 顺序**:
1. Dart 核心库
2. Flutter 框架
3. 第三方包
4. 项目内部包
5. 相对导入

### Python 规范

- 遵循 [PEP 8](https://pep8.org/) 代码风格
- 使用类型注解（type hints）
- 所有函数和类必须有 docstring
- 单元测试使用 `pytest`

**代码格式**:
```bash
cd server
black .           # 格式化
flake8 .         # 代码检查
mypy .           # 类型检查
```

### 命名规范

| 语言 | 类型 | 规范 | 示例 |
|------|------|------|------|
| Dart | 类名 | PascalCase | `class KeyItemModel` |
| Dart | 方法名 | camelCase | `void fetchData()` |
| Dart | 常量 | camelCase | `const apiBaseUrl` |
| Python | 类名 | PascalCase | `class AuthService` |
| Python | 函数名 | snake_case | `def get_user_info()` |
| Python | 常量 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |

---

## 提交规范

### 提交信息格式

```
<类型>(<范围>): <简短描述>

[可选的正文]

[可选的脚注]
```

### 类型标识

| 类型 | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat(auth): 添加生物识别登录` |
| `fix` | 修复 bug | `fix(sync): 修复冲突解决逻辑` |
| `docs` | 文档更新 | `docs: 更新 API 文档` |
| `style` | 代码格式（不影响功能） | `style: 格式化代码` |
| `refactor` | 重构（不修复问题或添加功能） | `refactor(crypto): 提取密钥派生逻辑` |
| `test` | 添加或修改测试 | `test: 添加加密服务单元测试` |
| `chore` | 构建或辅助工具变动 | `chore: 更新依赖版本` |

### 示例

```
feat(sync): 添加增量同步机制

- 实现基于版本号的增量同步
- 支持断点续传
- 添加同步状态回调

Closes #123
```

### 提交检查清单

- [ ] 提交信息清晰描述了更改内容
- [ ] 每个提交只包含一个逻辑变更
- [ ] 代码已通过 lint 检查
- [ ] 测试已添加/更新
- [ ] 文档已更新（如有必要）

---

## 测试指南

### 移动端测试

```bash
cd mobile

# 运行所有测试
flutter test

# 运行特定模块测试
flutter test test/core/crypto_service_test.dart

# 查看测试覆盖率
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 后端测试

```bash
cd server

# 运行所有测试
pytest

# 运行特定模块测试
pytest tests/test_auth.py

# 带覆盖率报告
pytest --cov=app --cov-report=html
```

### 测试要求

| 类型 | 要求 |
|------|------|
| 单元测试 | 所有公共方法必须有测试 |
| 集成测试 | API 端点必须有测试 |
| 覆盖率 | 核心模块 >= 80% |

---

## Pull Request 流程

### 创建 PR 前

1. 确保代码已同步最新上游
2. 所有测试通过
3. 代码已通过 lint 检查
4. 提交信息符合规范

### PR 模板

```markdown
## 描述
<!-- 简要描述这个 PR 做了什么 -->

## 改动类型
- [ ] 新功能 (feature)
- [ ] 修复 bug (fix)
- [ ] 重构 (refactor)
- [ ] 文档更新 (docs)
- [ ] 其他 (chore)

## 测试
- [ ] 已添加/更新测试
- [ ] 所有测试通过

## 截图（如有 UI 改动）
<!-- 添加截图 -->

## Checklist
- [ ] 代码遵循项目规范
- [ ] 提交信息符合规范
- [ ] 文档已更新（如有必要）
```

### Code Review

- 响应审查意见时，使用回复或提交新提交
- 标记已解决的讨论
- 不要强制推送已公开的提交

### 合并标准

PR 将被合并当：
- 至少 1 人审查通过
- 所有 CI 检查通过
- 无冲突

---

## 社区准则

### 行为准则

- 尊重他人，友善沟通
- 接受建设性批评
- 关注问题本身，而非人身攻击
- 尊重不同的技术观点和实现方式

### 问题反馈

- 提交 bug 报告时，提供详细的重现步骤
- 功能请求请说明使用场景
- 搜索现有 issue 避免重复

### 响应时间

- 维护者会尽快响应，但请耐心等待
- 长期未响应的 PR 可能会被关闭，请理解

---

## 常见问题

### Q: 如何处理大型重构？
**A**: 大型重构应拆分为多个小 PR，逐步合并。创建设计文档讨论方案。

### Q: 我的 PR 被拒绝了怎么办？
**A**: 仔细阅读反馈，进行修改。如果不同意，可以讨论但请保持专业态度。

### Q: 如何认领 issue？
**A**: 在 issue 下留言"我来处理"，等待维护者确认后即可开始工作。

---

## 下一步

准备好开始贡献了吗？

1. 查看 [开发指南](docs/development.md) 了解详细开发流程
2. 查看 [架构设计](docs/architecture.md) 了解系统设计
3. 查看 [移动端设计](docs/specs/mobile-design.md) 了解移动端实现

祝你贡献愉快！🎉
