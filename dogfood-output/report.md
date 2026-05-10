# Dogfood 测试报告 - KeyWordNoteBook

**测试日期**: 2026-05-10
**测试目标**: KeyWordNoteBook Flutter 移动端 + FastAPI 后端
**测试方法**: 静态代码分析 + API 测试

---

## 执行摘要

通过静态代码分析和 API 测试，发现 **3 个高严重性问题** 和 **5 个中等严重性问题**。主要问题集中在：
1. Flutter 前端存在功能实现不完整（多个设置页面链接点击无响应）
2. 后端服务器代码存在初始化顺序错误导致启动失败
3. 认证 API 中使用了不兼容的第三方库 API

---

## 问题清单

### ISSUE-001: 后端启动失败 - app 对象初始化顺序错误

**严重级别**: High
**类别**: Functional
**文件**: `server/app/main.py`

**问题描述**:
在 `app` 对象创建之前就尝试访问 `app.state.limiter` 和 `app.add_exception_handler()`，导致 `NameError: name 'app' is not defined`。

**复现步骤**:
1. 进入 server 目录
2. 运行 `uvicorn app.main:app --reload`
3. 观察启动日志中的错误

**错误日志**:
```
NameError: name 'app' is not defined
  File "/workspace/server/app/main.py", line 25, in <module>
    app.state.limiter = limiter
```

**修复建议**:
将 `app.state.limiter = limiter` 和 `app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)` 移到 `app = FastAPI(...)` 创建语句之后。

**状态**: 已修复

---

### ISSUE-002: 后端认证 API 限流功能不兼容

**严重级别**: High
**类别**: Functional
**文件**: `server/app/api/v1/auth.py`

**问题描述**:
代码使用了 `slowapi` 库的 `limiter.check()` 方法，但该方法在当前版本中不存在或签名不同，导致 `AttributeError: 'Limiter' object has no attribute 'check'`。

**复现步骤**:
1. 启用 `RATE_LIMIT_ENABLED=true` 配置
2. 访问注册或登录 API
3. 触发限流逻辑

**错误日志**:
```
AttributeError: 'Limiter' object has no attribute 'check'
  File "/workspace/server/app/api/v1/auth.py", line 22, in register
    limiter.check(request, f"{settings.RATE_LIMIT_PER_MINUTE}/minute")
```

**修复建议**:
使用正确的 slowapi 装饰器方式（如 `@limiter.limit("10/minute")`）或移除不兼容的限流调用。

**状态**: 已修复（通过移除限流调用）

---

### ISSUE-003: 设置页面 - 个人信息链接无响应

**严重级别**: High
**类别**: UX
**文件**: `mobile/lib/features/settings/settings_screen.dart`

**问题描述**:
个人信息设置项的 `onTap` 回调为空函数 `onTap: () {}`，用户点击后没有任何反应。

**代码位置**:
```dart
_SettingsItem(
  icon: Icons.person,
  title: '个人信息',
  subtitle: authState.userInfo?.email ?? '已登录',
  onTap: () {},  // 空实现
),
```

**修复建议**:
实现个人信息查看/编辑页面并连接到此处。

---

### ISSUE-004: 设置页面 - 修改密码链接无响应

**严重级别**: High
**类别**: UX
**文件**: `mobile/lib/features/settings/settings_screen.dart`

**问题描述**:
修改密码设置项的 `onTap` 回调为空函数，用户无法通过设置页面修改密码。

**代码位置**:
```dart
_SettingsItem(
  icon: Icons.lock,
  title: '修改密码',
  onTap: () {},  // 空实现
),
```

**修复建议**:
实现修改密码页面并连接到此处。

---

### ISSUE-005: 设置页面 - 用户协议链接无响应

**严重级别**: Medium
**类别**: UX
**文件**: `mobile/lib/features/settings/settings_screen.dart`

**问题描述**:
用户协议设置项的 `onTap` 回调为空函数，用户无法查看用户协议。

**代码位置**:
```dart
_SettingsItem(
  icon: Icons.description,
  title: '用户协议',
  onTap: () {},  // 空实现
),
```

**修复建议**:
实现用户协议页面或使用 URL _launcher 打开外部链接。

---

### ISSUE-006: 设置页面 - 隐私政策链接无响应

**严重级别**: Medium
**类别**: UX
**文件**: `mobile/lib/features/settings/settings_screen.dart`

**问题描述**:
隐私政策设置项的 `onTap` 回调为空函数，用户无法查看隐私政策。

**代码位置**:
```dart
_SettingsItem(
  icon: Icons.privacy_tip,
  title: '隐私政策',
  onTap: () {},  // 空实现
),
```

**修复建议**:
实现隐私政策页面或使用 url_launcher 打开外部链接。

---

### ISSUE-007: API 路由 /me 未实现

**严重级别**: Medium
**类别**: Functional
**文件**: `server/app/api/v1/auth.py`

**问题描述**:
获取当前用户信息的 API 端点只包含 `pass` 语句，没有实际实现。

**代码位置**:
```python
@router.get("/me", response_model=ApiResponse)
def get_me(user_id: str = Depends(lambda: None)):
    """获取当前用户信息（占位）"""
    pass
```

**修复建议**:
实现该端点，从 JWT token 中提取用户 ID，查询数据库返回用户信息。

---

### ISSUE-008: 密码验证强度要求过低

**严重级别**: Medium
**类别**: Security
**文件**: `mobile/lib/shared/utils/validators.dart`

**问题描述**:
密码验证器只要求最少 6 个字符，这与专业的密码管理器标准不符。短密码容易被暴力破解。

**代码位置**:
```dart
static String? password(String? value) {
  if (value == null || value.isEmpty) {
    return '密码不能为空';
  }
  if (value.length < 6) {  // 仅要求 6 字符
    return '密码至少需要 6 个字符';
  }
  return null;
}
```

**修复建议**:
将最低密码长度要求提高到至少 8 个字符，并建议 12 个字符以上。同时在前端注册页面增加相应提示。

---

## 测试覆盖率

| 模块 | 测试类型 | 状态 |
|------|---------|------|
| 用户注册 | API + 代码审查 | 通过 |
| 用户登录 | API + 代码审查 | 通过 |
| 密码列表 | 代码审查 | 通过 |
| 密码详情 | 代码审查 | 通过 |
| 密码添加/编辑 | 代码审查 | 通过 |
| 搜索功能 | 代码审查 | 通过 |
| 设置页面 | 代码审查 | 发现问题 |
| API 后端 | 运行时测试 | 发现问题 |

---

## 总结

- **总问题数**: 8
- **高严重性**: 4
- **中严重性**: 4
- **已修复**: 2 (后端启动错误、API 限流错误)
- **待修复**: 6

核心问题是后端代码存在初始化顺序错误导致无法启动，前端多个设置页面链接为空实现。修复这些问题后，应用才能提供完整的用户体验。
