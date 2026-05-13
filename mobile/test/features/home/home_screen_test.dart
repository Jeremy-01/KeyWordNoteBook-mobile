import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/core/network/api_response.dart';
import 'package:keybook/data/models/key_item_model.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/keybook_repository.dart';
import 'package:keybook/features/home/home_screen.dart';

import '../../test_helper.dart';

class _FakeKeyBookRepository extends KeyBookRepository {
  _FakeKeyBookRepository(this._items);

  final List<KeyItemModel> _items;

  @override
  Future<PaginatedResponse<KeyItemModel>> getItems({
    int page = 1,
    int pageSize = 20,
  }) async {
    return PaginatedResponse<KeyItemModel>(
      items: _items,
      total: _items.length,
      page: page,
      pageSize: pageSize,
    );
  }
}

void main() {
  setupTestEnvironment();

  testWidgets('首页在键盘弹出后不会出现 overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 780);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer(
      overrides: [
        keyBookRepositoryProvider.overrideWithValue(
          _FakeKeyBookRepository([
            KeyItemModel(
              itemId: 'item-1',
              index: '1',
              url: 'https://qa0513.com',
              username: 'qauser0513',
              passwordLevel: 4,
              linkUrl: '',
              note: '',
            ),
          ]),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(390, 780),
              viewInsets: EdgeInsets.only(bottom: 320),
            ),
            child: const HomeScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(TextField), findsOneWidget);
  });
}