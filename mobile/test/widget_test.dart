import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:keybook/core/constants/app_constants.dart';
import 'package:keybook/core/theme/keybook_theme.dart';
import 'package:keybook/shared/widgets/brand_banner.dart';

void main() {
  testWidgets('BrandBanner 应该展示统一的产品标识', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: KeyBookTheme.light(),
        home: const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(24),
            child: BrandBanner(
              subtitle: '与你的桌面端保持一致的安全密码体验',
              supportingText: '端到端加密、生物识别解锁与多端同步',
            ),
          ),
        ),
      ),
    );

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('与你的桌面端保持一致的安全密码体验'), findsOneWidget);
    expect(find.text('端到端加密、生物识别解锁与多端同步'), findsOneWidget);
    expect(find.byIcon(Icons.key_rounded), findsOneWidget);
  });
}
