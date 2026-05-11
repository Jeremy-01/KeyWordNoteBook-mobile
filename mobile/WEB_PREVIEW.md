# Flutter Web 云端预览

这个仓库配置了自动将 KeyWordNoteBook Flutter 移动应用部署为 Web 版本的工作流。

## 如何使用

### 1. 启用 GitHub Pages

1. 访问仓库设置页面 https://github.com/Jeremy-01/KeyWordNoteBook/settings/pages
2. 在 "Build and deployment" 部分，选择 "Source" 为 "GitHub Actions"

### 2. 自动部署

每当代码推送到 `mobile` 分支时，GitHub Actions 将自动：
- 构建 Flutter Web 版本
- 部署到 GitHub Pages

### 3. 预览地址

部署完成后，应用将在以下地址可访问：
```
https://jeremy-01.github.io/KeyWordNoteBook/
```

## 手动构建和预览

如果你想在本地测试 Web 版本：

```bash
cd mobile
flutter config --enable-web
flutter run -d chrome
```

## 工作流文件

工作流定义在：[`.github/workflows/flutter-web-preview.yml`](/.github/workflows/flutter-web-preview.yml)

## 注意事项

- 某些移动特定功能（如生物识别）在 Web 版本中可能不可用
- 本地存储在 Web 中使用浏览器存储，与移动端不完全一致
