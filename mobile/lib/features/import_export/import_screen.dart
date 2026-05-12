import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../core/export/import_service.dart';
import '../../data/providers/keybook_provider.dart';

final importServiceProvider = Provider<ImportService>((ref) {
  return ImportService();
});

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  bool _isImporting = false;
  List<dynamic>? _previewItems;
  String? _selectedFilePath;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导入数据'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '导入说明',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• 支持 CSV 格式导入\n'
                      '• 支持加密备份导入\n'
                      '• 请确保文件格式正确',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_selectedFilePath != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '已选择: $_selectedFilePath',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (_previewItems != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          '预览: ${_previewItems!.length} 个密码条目',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Spacer(),
            OutlinedButton.icon(
              onPressed: _isImporting ? null : _selectFile,
              icon: const Icon(Icons.folder_open),
              label: const Text('选择文件'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (_selectedFilePath == null || _isImporting) ? null : _handleImport,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isImporting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('开始导入'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'json'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final file = File(filePath);
        final content = await file.readAsString();

        setState(() {
          _selectedFilePath = filePath;
          _errorMessage = null;
        });

        if (filePath.endsWith('.csv')) {
          await _previewCsv(content);
        } else if (filePath.endsWith('.json')) {
          await _previewJson(content);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = '文件读取失败: $e';
      });
    }
  }

  Future<void> _previewCsv(String content) async {
    try {
      final importService = ref.read(importServiceProvider);
      final items = await importService.parseCsv(content);
      final validation = importService.validateItems(items);

      setState(() {
        _previewItems = items;
        _errorMessage = validation.failedCount > 0
            ? '警告: ${validation.failedCount} 条数据验证失败'
            : null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'CSV 解析失败: $e';
      });
    }
  }

  Future<void> _previewJson(String content) async {
    try {
      final importService = ref.read(importServiceProvider);
      List<dynamic> items;

      if (content.contains('encrypted_keybook_backup')) {
        setState(() {
          _errorMessage = '加密备份需要在导入时输入密码';
        });
        return;
      }

      items = await importService.parsePlainJson(content);

      setState(() {
        _previewItems = items;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'JSON 解析失败: $e';
      });
    }
  }

  Future<void> _handleImport() async {
    if (_previewItems == null || _previewItems!.isEmpty) {
      _showError('没有可导入的数据');
      return;
    }

    setState(() => _isImporting = true);

    try {
      final keyBookNotifier = ref.read(keyBookProvider.notifier);

      int importedCount = 0;
      for (final item in _previewItems!) {
        final result = await keyBookNotifier.addItem(item);
        if (result != null) {
          importedCount++;
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('成功导入 $importedCount 个密码条目')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showError('导入失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
