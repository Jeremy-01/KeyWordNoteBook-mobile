import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/core/network/api_response.dart';
import 'package:keybook/data/models/key_item_model.dart';
import 'package:keybook/data/providers/keybook_provider.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/keybook_repository.dart';
import 'package:keybook/features/item/item_detail_screen.dart';

import '../../test_helper.dart';

class _FakeKeyBookRepository extends KeyBookRepository {
  _FakeKeyBookRepository(
    this._listItems,
    this._detailItems,
  );

  final Map<String, KeyItemModel> _listItems;
  final Map<String, KeyItemModel> _detailItems;

  @override
  Future<PaginatedResponse<KeyItemModel>> getItems({
    int page = 1,
    int pageSize = 20,
  }) async {
    final items = _listItems.values.toList();
    return PaginatedResponse<KeyItemModel>(
      items: items,
      total: items.length,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<KeyItemModel> getItemDetail(String itemId) async {
    return _detailItems[itemId]!;
  }

  @override
  Future<void> updateItem(String itemId, KeyItemModel item) async {
    final updated = item.copyWith(itemId: itemId);
    _listItems[itemId] = updated;
    _detailItems[itemId] = updated;
  }
}

void main() {
  setupTestEnvironment();

  Future<ProviderContainer> pumpDetailScreen(
    WidgetTester tester,
    KeyItemModel initialItem,
    KeyItemModel? detailItem,
  ) async {
    final repository = _FakeKeyBookRepository(
      {'item-1': initialItem},
      {'item-1': detailItem ?? initialItem},
    );
    final container = ProviderContainer(
      overrides: [
        keyBookRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(keyBookProvider.notifier).loadItems(refresh: true);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ItemDetailScreen(itemId: 'item-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    return container;
  }

  testWidgets('详情页会在 provider 条目更新后同步显示新用户名', (tester) async {
    final initialItem = KeyItemModel(
      itemId: 'item-1',
      index: '1',
      url: 'https://example.com',
      username: 'qa_user5',
      password: 'Abcd1234Z',
      passwordLevel: 4,
      linkUrl: '',
      note: '',
    );
    final container = await pumpDetailScreen(tester, initialItem, null);

    expect(find.text('qa_user5'), findsOneWidget);

    await container.read(keyBookProvider.notifier).updateItem(
          'item-1',
          initialItem.copyWith(username: 'qa_user6'),
        );
    await tester.pump();

    expect(find.text('qa_user6'), findsOneWidget);
    expect(find.text('qa_user5'), findsNothing);
  });

  testWidgets('详情页编辑保存后会回到详情并显示新用户名', (tester) async {
    final initialItem = KeyItemModel(
      itemId: 'item-1',
      index: '1',
      url: 'https://example.com',
      username: 'qa_user8',
      password: 'Abcd1234Z',
      passwordLevel: 4,
      linkUrl: '',
      note: '',
    );
    final container = await pumpDetailScreen(tester, initialItem, null);

    expect(find.text('qa_user8'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.text('编辑密码'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(1), 'qa_user9');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(find.text('qa_user9'), findsOneWidget);
    expect(find.text('qa_user8'), findsNothing);
    expect(
      container.read(keyBookProvider).items.single.username,
      'qa_user9',
    );
  });

  testWidgets('详情页进入编辑时会保留详情接口返回的密码字段', (tester) async {
    final listItem = KeyItemModel(
      itemId: 'item-1',
      index: '1',
      url: 'https://example.com',
      username: 'qa_user10',
      password: null,
      passwordLevel: 4,
      linkUrl: '',
      note: '',
    );
    final detailItem = listItem.copyWith(password: 'Abcd1234Z');

    await pumpDetailScreen(tester, listItem, detailItem);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.text('编辑密码'), findsOneWidget);

    final passwordField = tester.widget<TextFormField>(
      find.byType(TextFormField).at(2),
    );
    expect(passwordField.controller?.text, 'Abcd1234Z');
  });
}