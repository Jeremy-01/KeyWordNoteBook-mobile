// 添加/编辑密码页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/keybook_provider.dart';
import '../../data/models/key_item_model.dart';
import '../../data/providers/settings_provider.dart';
import '../../core/crypto/crypto_service.dart';
import '../../shared/widgets/widgets.dart';
import '../../shared/utils/validators.dart';
import '../generator/password_generator_screen.dart';

class ItemEditScreen extends ConsumerStatefulWidget {
  final KeyItemModel? item;

  const ItemEditScreen({
    super.key,
    this.item,
  });

  @override
  ConsumerState<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends ConsumerState<ItemEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _linkController = TextEditingController();
  final _noteController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    _obscurePassword = ref.read(settingsProvider).hidePasswords;
    if (widget.item != null) {
      _urlController.text = widget.item!.url;
      _usernameController.text = widget.item!.username;
      _passwordController.text = widget.item!.password ?? '';
      _linkController.text = widget.item!.linkUrl;
      _noteController.text = widget.item!.note;
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _linkController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final item = KeyItemModel(
      itemId: widget.item?.itemId ?? '',
      index: widget.item?.index ?? '',
      url: _urlController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text,
      passwordLevel: CryptoService.getPasswordLevel(_passwordController.text),
      linkUrl: _linkController.text.trim(),
      note: _noteController.text.trim(),
    );

    try {
      final notifier = ref.read(keyBookProvider.notifier);
      final state = ref.read(keyBookProvider);
      bool success;
      if (_isEditing) {
        success = await notifier.updateItem(widget.item!.apiId, item);
      } else {
        success = await notifier.addItem(item) != null;
      }

      if (success && mounted) {
        if (_isEditing) {
          final updatedItem = widget.item!.copyWith(
            url: item.url,
            username: item.username,
            password: item.password,
            passwordLevel: item.passwordLevel,
            linkUrl: item.linkUrl,
            note: item.note,
          );
          Navigator.of(context).pop(
            updatedItem,
          );
        } else {
          Navigator.of(context).pop(true);
        }
      } else if (mounted) {
        final error = ref.read(keyBookProvider).error ?? state.error ?? '保存失败';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑密码' : '添加密码'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _handleSave,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('保存'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _urlController,
                label: '网站',
                hint: 'https://example.com',
                keyboardType: TextInputType.url,
                prefixIcon: const Icon(Icons.language),
                validator: (v) => Validators.required(v, '网站'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _usernameController,
                label: '用户名 / 邮箱',
                hint: '请输入用户名或邮箱',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.person),
                validator: (v) => Validators.required(v, '用户名'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _passwordController,
                label: '密码',
                hint: '请输入密码',
                obscureText: _obscurePassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.auto_awesome),
                      tooltip: '生成密码',
                      onPressed: () async {
                        await showPasswordGeneratorDialog(
                          context,
                          onPasswordGenerated: (password) {
                            _passwordController.text = password;
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
                validator: (v) => Validators.required(v, '密码'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
              PasswordStrengthIndicator(password: _passwordController.text),
              const SizedBox(height: 16),
              AppTextField(
                controller: _linkController,
                label: '链接（可选）',
                hint: '相关链接',
                keyboardType: TextInputType.url,
                prefixIcon: const Icon(Icons.link),
                validator: Validators.url,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _noteController,
                label: '备注（可选）',
                hint: '添加备注信息',
                maxLines: 3,
                prefixIcon: const Icon(Icons.note),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
