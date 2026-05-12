// 密码本状态管理 - Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';
import '../models/key_item_model.dart';
import '../repositories/keybook_repository.dart';
import 'providers.dart';

enum SortOption {
  name,
  createdAt,
  updatedAt,
}

enum FilterOption {
  all,
  favorites,
}

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
  final SortOption sortOption;
  final FilterOption filterOption;

  KeyBookState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
    this.syncVersion = 0,
    this.selectedItem,
    this.sortOption = SortOption.name,
    this.filterOption = FilterOption.all,
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
    SortOption? sortOption,
    FilterOption? filterOption,
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
      sortOption: sortOption ?? this.sortOption,
      filterOption: filterOption ?? this.filterOption,
    );
  }
}

/// 密码本状态管理器
class KeyBookNotifier extends StateNotifier<KeyBookState> {
  final KeyBookRepository _repository;

  KeyBookNotifier(this._repository) : super(KeyBookState());

  String _messageForError(Object error) {
    return error is ApiException ? error.message : error.toString();
  }

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
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _messageForError(e),
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
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: _messageForError(e),
      );
    }
  }

  Future<String?> addItem(KeyItemModel item) async {
    try {
      final itemId = await _repository.addItem(item);
      state = state.copyWith(
        items: [...state.items, item.copyWith(itemId: itemId)],
        syncVersion: state.syncVersion + 1,
        error: null,
      );
      return itemId;
    } catch (e) {
      state = state.copyWith(error: _messageForError(e));
      return null;
    }
  }

  Future<bool> updateItem(String itemId, KeyItemModel item) async {
    try {
      await _repository.updateItem(itemId, item);
      final updatedItems = state.items.map((i) {
        if (i.apiId == itemId) return item.copyWith(itemId: itemId, index: i.index);
        return i;
      }).toList();
      state = state.copyWith(
        items: updatedItems,
        syncVersion: state.syncVersion + 1,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: _messageForError(e));
      return false;
    }
  }

  Future<bool> deleteItem(String itemId) async {
    try {
      await _repository.deleteItem(itemId);
      state = state.copyWith(
        items: state.items.where((i) => i.apiId != itemId).toList(),
        syncVersion: state.syncVersion + 1,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: _messageForError(e));
      return false;
    }
  }

  Future<KeyItemModel?> getItemDetail(String itemId) async {
    try {
      final item = await _repository.getItemDetail(itemId);
      state = state.copyWith(selectedItem: item, error: null);
      return item;
    } catch (e) {
      state = state.copyWith(error: _messageForError(e));
      return null;
    }
  }

  void selectItem(KeyItemModel? item) {
    state = state.copyWith(selectedItem: item);
  }

  Future<bool> toggleFavorite(String itemId) async {
    try {
      final itemIndex = state.items.indexWhere((i) => i.apiId == itemId);
      if (itemIndex == -1) return false;

      final item = state.items[itemIndex];
      final updatedItem = item.copyWith(isFavorite: !item.isFavorite);
      await _repository.updateItem(itemId, updatedItem);

      final updatedItems = [...state.items];
      updatedItems[itemIndex] = updatedItem;

      state = state.copyWith(
        items: updatedItems,
        syncVersion: state.syncVersion + 1,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: _messageForError(e));
      return false;
    }
  }

  void setSortOption(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void setFilterOption(FilterOption option) {
    state = state.copyWith(filterOption: option);
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
  final sortOption = ref.watch(keyBookProvider.select((s) => s.sortOption));
  final filterOption = ref.watch(keyBookProvider.select((s) => s.filterOption));

  var filtered = items.where((item) {
    if (filterOption == FilterOption.favorites && !item.isFavorite) {
      return false;
    }
    if (query.isEmpty) return true;
    return item.url.toLowerCase().contains(query) ||
        item.username.toLowerCase().contains(query) ||
        item.note.toLowerCase().contains(query);
  }).toList();

  switch (sortOption) {
    case SortOption.name:
      filtered.sort((a, b) => a.url.compareTo(b.url));
      break;
    case SortOption.createdAt:
      filtered.sort((a, b) {
        final aTime = a.createdAt ?? DateTime(1970);
        final bTime = b.createdAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });
      break;
    case SortOption.updatedAt:
      filtered.sort((a, b) {
        final aTime = a.updatedAt ?? DateTime(1970);
        final bTime = b.updatedAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });
      break;
  }

  return filtered;
});
