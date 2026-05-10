/// 密码本状态管理 - Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/key_item_model.dart';
import '../models/sync_models.dart';
import '../repositories/keybook_repository.dart';
import 'providers.dart';

/// 密码本状态
class KeyBookState {
  final List<KeyItemModel> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final bool hasMore;
  final int syncVersion;
  final KeyItemModel? selectedItem;

  KeyBookState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
    this.syncVersion = 0,
    this.selectedItem,
  });

  KeyBookState copyWith({
    List<KeyItemModel>? items,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    bool? hasMore,
    int? syncVersion,
    KeyItemModel? selectedItem,
  }) {
    return KeyBookState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      syncVersion: syncVersion ?? this.syncVersion,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}

/// 密码本状态管理器
class KeyBookNotifier extends StateNotifier<KeyBookState> {
  final KeyBookRepository _repository;

  KeyBookNotifier(this._repository) : super(KeyBookState());

  Future<void> loadItems({bool refresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      currentPage: refresh ? 1 : state.currentPage,
      items: refresh ? [] : state.items,
    );

    try {
      final response = await _repository.getItems(
        page: refresh ? 1 : state.currentPage,
      );

      state = state.copyWith(
        isLoading: false,
        items: refresh ? response.items : [...state.items, ...response.items],
        hasMore: response.hasMore,
        currentPage: response.page + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final response = await _repository.getItems(page: state.currentPage);

      state = state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...response.items],
        hasMore: response.hasMore,
        currentPage: response.page + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<String?> addItem(KeyItemModel item) async {
    try {
      final index = await _repository.addItem(item);
      state = state.copyWith(
        items: [...state.items, item.copyWith(index: index)],
        syncVersion: state.syncVersion + 1,
      );
      return index;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  Future<bool> updateItem(String itemId, KeyItemModel item) async {
    try {
      await _repository.updateItem(itemId, item);
      final updatedItems = state.items.map((i) {
        if (i.index == itemId) return item.copyWith(index: itemId);
        return i;
      }).toList();
      state = state.copyWith(
        items: updatedItems,
        syncVersion: state.syncVersion + 1,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> deleteItem(String itemId) async {
    try {
      await _repository.deleteItem(itemId);
      state = state.copyWith(
        items: state.items.where((i) => i.index != itemId).toList(),
        syncVersion: state.syncVersion + 1,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<KeyItemModel?> getItemDetail(String itemId) async {
    try {
      final item = await _repository.getItemDetail(itemId);
      state = state.copyWith(selectedItem: item);
      return item;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  void selectItem(KeyItemModel? item) {
    state = state.copyWith(selectedItem: item);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clear() {
    state = KeyBookState();
  }
}

/// 密码本 Provider
final keyBookProvider = StateNotifierProvider<KeyBookNotifier, KeyBookState>((ref) {
  final repository = ref.watch(keyBookRepositoryProvider);
  return KeyBookNotifier(repository);
});

/// 选中条目 Provider
final selectedItemProvider = StateProvider<KeyItemModel?>((ref) => null);

/// 搜索关键词 Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// 过滤后的密码列表
final filteredItemsProvider = Provider<List<KeyItemModel>>((ref) {
  final items = ref.watch(keyBookProvider).items;
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return items;

  return items.where((item) {
    return item.url.toLowerCase().contains(query) ||
        item.username.toLowerCase().contains(query) ||
        item.note.toLowerCase().contains(query);
  }).toList();
});
