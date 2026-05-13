// 密码详情页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/clipboard_utils.dart';
import '../../data/models/key_item_model.dart';
import '../../data/providers/keybook_provider.dart';
import '../../data/providers/settings_provider.dart';
import 'item_edit_screen.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  final String itemId;

  const ItemDetailScreen({
    super.key,
    required this.itemId,
  });

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  KeyItemModel? _item;
  bool _isLoading = true;
  bool _showPassword = false;
  String? _error;
  late final ProviderSubscription<KeyBookState> _keyBookSubscription;

  @override
  void initState() {
    super.initState();
    _keyBookSubscription = ref.listenManual<KeyBookState>(
      keyBookProvider,
      (_, next) {
        final updatedItem = _mergeDisplayItem(_findStateItem(next.items), _item);
        if (!mounted || updatedItem == null) {
          return;
        }

        if (_item?.url == updatedItem.url &&
            _item?.username == updatedItem.username &&
            _item?.password == updatedItem.password &&
            _item?.passwordLevel == updatedItem.passwordLevel &&
            _item?.linkUrl == updatedItem.linkUrl &&
            _item?.note == updatedItem.note &&
            _item?.isFavorite == updatedItem.isFavorite) {
          return;
        }

        setState(() {
          _item = updatedItem;
          _error = null;
          _isLoading = false;
        });
      },
    );
    _loadItem();
  }

  @override
  void dispose() {
    _keyBookSubscription.close();
    super.dispose();
  }

  KeyItemModel? _findStateItem(List<KeyItemModel> items) {
    for (final item in items) {
      if (item.apiId == widget.itemId) {
        return item;
      }
    }
    return null;
  }

  KeyItemModel? _mergeDisplayItem(
    KeyItemModel? stateItem,
    KeyItemModel? detailItem,
  ) {
    if (stateItem == null) {
      return detailItem;
    }
    if (detailItem == null) {
      return stateItem;
    }

    final hasPassword = stateItem.password != null && stateItem.password!.isNotEmpty;
    return stateItem.copyWith(
      password: hasPassword ? stateItem.password : detailItem.password,
      passwordLevel:
          hasPassword ? stateItem.passwordLevel : detailItem.passwordLevel,
    );
  }

  Future<void> _loadItem({bool showLoading = true}) async {
    if (showLoading) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    } else {
      setState(() {
        _error = null;
      });
    }

    try {
      final item = await ref
          .read(keyBookProvider.notifier)
          .getItemDetail(widget.itemId);
      if (!mounted) return;
      setState(() {
        _item = item;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        if (showLoading || _item == null) {
          _error = e.toString();
        }
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard(String text, String label) {
    ClipboardUtils.copyWithAutoClear(context, text, label: label);
  }

  @override
  Widget build(BuildContext context) {
    final keyBookState = ref.watch(keyBookProvider);
    final syncedItem = _findStateItem(keyBookState.items);
    final displayItem = _mergeDisplayItem(syncedItem, _item);
    final hidePasswords = ref.watch(
      settingsProvider.select((state) => state.hidePasswords),
    );
    final passwordVisible = !hidePasswords || _showPassword;

    return Scaffold(
      appBar: AppBar(
        title: const Text('密码详情'),
        actions: [
          if (displayItem != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.of(context).push<Object?>(
                  MaterialPageRoute(
                    builder: (_) => ItemEditScreen(item: displayItem),
                  ),
                );

                if (!mounted || result == null) {
                  return;
                }

                if (result is KeyItemModel) {
                  setState(() {
                    _item = result;
                    _error = null;
                    _isLoading = false;
                  });
                  return;
                }

                if (result == true) {
                  await _loadItem();
                }
              },
            ),
        ],
      ),
      body: _buildBody(
        item: displayItem,
        hidePasswords: hidePasswords,
        passwordVisible: passwordVisible,
      ),
    );
  }

  Widget _buildBody({
    required KeyItemModel? item,
    required bool hidePasswords,
    required bool passwordVisible,
  }) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadItem,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (item == null) {
      return const Center(child: Text('未找到密码条目'));
    }

    final currentItem = item;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _DetailCard(
            label: '网站',
            value: currentItem.url,
            icon: Icons.language,
            onCopy: () => _copyToClipboard(currentItem.url, '网址'),
          ),
          const SizedBox(height: 16),
          _DetailCard(
            label: '用户名',
            value: currentItem.username,
            icon: Icons.person,
            onCopy: () => _copyToClipboard(currentItem.username, '用户名'),
          ),
          const SizedBox(height: 16),
          _DetailCard(
            label: '密码',
            value: passwordVisible ? (currentItem.password ?? '') : '••••••••',
            icon: Icons.lock,
            isPassword: true,
            showPassword: passwordVisible,
            onToggleVisibility: hidePasswords
                ? () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  }
                : null,
            onCopy: () {
              if (currentItem.password != null) {
                _copyToClipboard(currentItem.password!, '密码');
              }
            },
          ),
          if (currentItem.linkUrl.isNotEmpty) ...[
            const SizedBox(height: 16),
            _DetailCard(
              label: '链接',
              value: currentItem.linkUrl,
              icon: Icons.link,
              onCopy: () => _copyToClipboard(currentItem.linkUrl, '链接'),
            ),
          ],
          if (currentItem.note.isNotEmpty) ...[
            const SizedBox(height: 16),
            _DetailCard(
              label: '备注',
              value: currentItem.note,
              icon: Icons.note,
            ),
          ],
          const SizedBox(height: 16),
          _buildPasswordStrength(currentItem),
        ],
      ),
    );
  }

  Widget _buildPasswordStrength(KeyItemModel item) {
    final level = item.passwordLevel;
    final color = switch (level) {
      0 => Colors.red,
      1 => Colors.orange,
      2 => Colors.yellow.shade700,
      3 => Colors.lightGreen,
      4 => Colors.green,
      _ => Colors.grey,
    };
    final text = switch (level) {
      0 => '极弱',
      1 => '弱',
      2 => '一般',
      3 => '良好',
      4 => '强',
      _ => '未知',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '密码强度',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: level / 4,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isPassword;
  final bool showPassword;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onCopy;

  const _DetailCard({
    required this.label,
    required this.value,
    required this.icon,
    this.isPassword = false,
    this.showPassword = false,
    this.onToggleVisibility,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isPassword && onToggleVisibility != null)
                  IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onToggleVisibility,
                    iconSize: 20,
                  ),
                if (onCopy != null)
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: onCopy,
                    iconSize: 20,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
