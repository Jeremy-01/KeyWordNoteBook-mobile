import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私政策'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '隐私政策',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '最后更新日期: 2026-01-01',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'KeyWordNoteBook 高度重视您的隐私保护。本隐私政策说明了我们如何收集、使用、存储和保护您的信息。\n\n'
              '一、信息收集\n\n'
              '1. 账户信息：当您注册账户时，我们会收集您的邮箱地址。\n\n'
              '2. 密码数据：您存储的密码信息会经过本地加密后同步，我们的服务器不会存储您的明文密码数据。\n\n'
              '3. 使用日志：为改进服务质量，我们可能会收集有限的使用统计数据，例如功能使用频率。\n\n'
              '二、信息使用\n\n'
              '我们收集的信息仅用于以下目的：\n'
              '• 提供和维护服务\n'
              '• 改进和优化用户体验\n'
              '• 安全监控和欺诈预防\n\n'
              '三、信息保护\n\n'
              '1. 端到端加密：您的密码数据在设备端加密后才会同步到云端。\n'
              '2. 安全传输：所有数据传输均使用 TLS 加密。\n'
              '3. 访问控制：严格限制员工对用户数据的访问。\n\n'
              '四、信息共享\n\n'
              '我们不会将您的个人信息出售给任何第三方，除非：\n'
              '• 获得您的明确同意\n'
              '• 法律要求\n\n'
              '五、您的权利\n\n'
              '您有权：\n'
              '• 访问您的个人信息\n'
              '• 更正不准确的信息\n'
              '• 删除您的账户和数据\n'
              '• 导出您的数据\n\n'
              '六、联系我们\n\n'
              '如您对本隐私政策有任何疑问，请通过应用内反馈功能联系我们。',
              style: TextStyle(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
