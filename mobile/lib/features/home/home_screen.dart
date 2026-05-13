// 主页 - 密码列表
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/providers/keybook_provider.dart';
import '../../data/models/key_item_model.dart';
import '../../shared/widgets/brand_banner.dart';
import '../item/item_edit_screen.dart';
import '../item/item_detail_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(keyBookProvider.notifier).loadItems(refresh: true);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBookState = ref.watch(keyBookProvider);
    final filteredItems = ref.watch(filteredItemsProvider);
    final totalItems = keyBookState.items.length;
    final resultCount = filteredItems.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ref.read(keyBookProvider.notifier).loadItems(refresh: true);
            },
          ),
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (option) {
              ref.read(keyBookProvider.notifier).setSortOption(option);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: SortOption.name,
                child: Row(
                  children: [
                    if (keyBookState.sortOption == SortOption.name)
                      const Icon(Icons.check, size: 18),
                    const SizedBox(width: 8),
                    const Text('按名称排序'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOption.createdAt,
                child: Row(
                  children: [
                    if (keyBookState.sortOption == SortOption.createdAt)
                      const Icon(Icons.check, size: 18),
                    const SizedBox(width: 8),
                    const Text('按创建时间排序'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: SortOption.updatedAt,
                child: Row(
                  children: [
                    if (keyBookState.sortOption == SortOption.updatedAt)
                      const Icon(Icons.check, size: 18),
                    const SizedBox(width: 8),
                    const Text('按更新时间排序'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(keyBookProvider.notifier).loadItems(refresh: true);
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _buildHeaderCard(
                  state: keyBookState,
                  totalItems: totalItems,
                  resultCount: resultCount,
                ),
              ),
            ),
            ..._buildBodySlivers(keyBookState, filteredItems),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ItemEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    setState(() {});
  }

  String _getSortLabel(SortOption option) {
    return switch (option) {
      SortOption.name => '按名称排序',
      SortOption.createdAt => '按创建时间排序',
      SortOption.updatedAt => '按更新时间排序',
    };
  }

  Widget _buildHeaderCard({
    required KeyBookState state,
    required int totalItems,
    required int resultCount,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BrandBanner(
              compact: true,
              subtitle: state.filterOption == FilterOption.favorites
                  ? '收藏模式已开启'
                  : '桌面与移动端统一的加密密码体验',
              supportingText: '已保存 $totalItems 条条目，当前显示 $resultCount 条结果',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索站点、账号或备注',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _clearSearch,
                      ),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: state.filterOption == FilterOption.all,
                  onSelected: (_) {
                    ref
                        .read(keyBookProvider.notifier)
                        .setFilterOption(FilterOption.all);
                  },
                ),
                FilterChip(
                  avatar: Icon(
                    state.filterOption == FilterOption.favorites
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 18,
                  ),
                  label: const Text('收藏'),
                  selected: state.filterOption == FilterOption.favorites,
                  onSelected: (_) {
                    ref
                        .read(keyBookProvider.notifier)
                        .setFilterOption(FilterOption.favorites);
                  },
                ),
                _MetaChip(
                  icon: Icons.inventory_2_outlined,
                  label: '$resultCount 条结果',
                ),
                _MetaChip(
                  icon: Icons.swap_vert,
                  label: _getSortLabel(state.sortOption),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBodySlivers(KeyBookState state, List<KeyItemModel> items) {
    if (state.isLoading && items.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (state.error != null && items.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(state.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(keyBookProvider.notifier).loadItems(refresh: true);
                  },
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    if (items.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '暂无密码条目',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  '点击右下角按钮开始构建你的加密密码库',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = items[index];
            return _KeyItemCard(
              item: item,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ItemDetailScreen(itemId: item.apiId),
                  ),
                );
              },
              onEdit: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ItemEditScreen(item: item),
                  ),
                );
              },
              onDelete: () => _showDeleteDialog(item),
              onToggleFavorite: () {
                ref.read(keyBookProvider.notifier).toggleFavorite(item.apiId);
              },
            );
          }, childCount: items.length),
        ),
      ),
    ];
  }

  Future<void> _showDeleteDialog(KeyItemModel item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除确认'),
        content: Text('确定要删除 "${item.url}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(keyBookProvider.notifier).deleteItem(item.apiId);
    }
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(icon, size: 18, color: colorScheme.primary),
      label: Text(label),
      backgroundColor: colorScheme.surface,
      side: BorderSide(color: colorScheme.outlineVariant),
    );
  }
}

class _KeyItemCard extends StatelessWidget {
  final KeyItemModel item;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;

  const _KeyItemCard({
    required this.item,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    _getSiteInitial(item.url),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getSiteName(item.url),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.isFavorite)
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.username,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              _buildPasswordStrengthIndicator(item.passwordLevel),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                  if (value == 'favorite') onToggleFavorite();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'favorite',
                    child: Row(
                      children: [
                        Icon(
                          item.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: item.isFavorite ? Colors.red : null,
                        ),
                        const SizedBox(width: 8),
                        Text(item.isFavorite ? '取消收藏' : '收藏'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('编辑'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('删除', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator(int level) {
    final color = switch (level) {
      0 => Colors.red,
      1 => Colors.orange,
      2 => Colors.yellow.shade700,
      3 => Colors.lightGreen,
      4 => Colors.green,
      _ => Colors.grey,
    };

    return Container(
      width: 8,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  String _getSiteName(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    final normalized = trimmed.contains('://') ? trimmed : 'https://$trimmed';
    final uri = Uri.tryParse(normalized);
    final host = uri?.host.trim();
    if (host != null && host.isNotEmpty) {
      return host.replaceFirst(RegExp(r'^www\.'), '');
    }

    return trimmed.split('/').first.replaceFirst(RegExp(r'^www\.'), '');
  }

  String _getSiteInitial(String url) {
    final name = _getSiteName(url);
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
