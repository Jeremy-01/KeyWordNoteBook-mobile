/// 密码详情页面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/keybook_provider.dart';
import '../../data/models/key_item_model.dart';
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

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final item = await ref
          .read(keyBookProvider.notifier)
          .getItemDetail(widget.itemId);
      setState(() {
        _item = item;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label 已复制到剪贴板'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('密码详情'),
        actions: [
          if (_item != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ItemEditScreen(item: _item),
                  ),
                );
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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

    if (_item == null) {
      return const Center(child: Text('未找到密码条目'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _DetailCard(
            label: '网站',
            value: _item!.url,
            icon: Icons.language,
            onCopy: () => _copyToClipboard(_item!.url, '网址'),
          ),
          const SizedBox(height: 16),
          _DetailCard(
            label: '用户名',
            value: _item!.username,
            icon: Icons.person,
            onCopy: () => _copyToClipboard(_item!.username, '用户名'),
          ),
          const SizedBox(height: 16),
          _DetailCard(
            label: '密码',
            value: _showPassword ? (_item!.password ?? '') : '••••••••',
            icon: Icons.lock,
            isPassword: true,
            showPassword: _showPassword,
            onToggleVisibility: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            onCopy: () {
              if (_item!.password != null) {
                _copyToClipboard(_item!.password!, '密码');
              }
            },
          ),
          if (_item!.linkUrl != null && _item!.linkUrl!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _DetailCard(
              label: '链接',
              value: _item!.linkUrl!,
              icon: Icons.link,
              onCopy: () => _copyToClipboard(_item!.linkUrl!, '链接'),
            ),
          ],
          if (_item!.note != null && _item!.note!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _DetailCard(
              label: '备注',
              value: _item!.note!,
              icon: Icons.note,
            ),
          ],
          const SizedBox(height: 16),
          _buildPasswordStrength(),
        ],
      ),
    );
  }

  Widget _buildPasswordStrength() {
    final level = _item!.passwordLevel;
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
