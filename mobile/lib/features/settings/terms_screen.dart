import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户协议'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KeyWordNoteBook 用户协议',
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
              '欢迎使用 KeyWordNoteBook。\n\n'
              '请您在使用本应用前仔细阅读本用户协议。一旦您开始使用本应用，即表示您同意接受本协议的全部条款和条件。\n\n'
              '一、服务说明\n\n'
              'KeyWordNoteBook 是一款密码管理应用，提供密码存储、加密、同步等功能。我们致力于保护您的隐私和数据安全。\n\n'
              '二、账户注册\n\n'
              '您需要提供真实、准确的个人信息进行注册。您有责任妥善保管您的账户信息，包括主密码。如因您保管不善导致的损失，由您自行承担。\n\n'
              '三、数据安全\n\n'
              '1. 您的所有密码数据均使用 AES-256-GCM 加密存储。\n'
              '2. 加密密钥基于您的主动密码派生，我们不会存储您的明文密码。\n'
              '3. 请勿遗忘您的主密码，一旦遗忘将无法恢复。\n\n'
              '四、使用限制\n\n'
              '您同意不会将本服务用于任何非法目的，也不会违反任何适用的法律法规。\n\n'
              '五、免责声明\n\n'
              '本应用按"现状"提供，我们不对服务的及时性、安全性、准确性做任何明示或暗示的保证。\n\n'
              '六、协议修改\n\n'
              '我们保留随时修改本协议的权利。修改后的协议将在应用内公布。如您继续使用服务，视为接受修改后的协议。\n\n'
              '如有任何问题，请联系我们。',
              style: TextStyle(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
