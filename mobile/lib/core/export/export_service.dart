import 'dart:convert';
import 'package:csv/csv.dart';
import '../crypto/crypto_service.dart';
import '../../data/models/key_item_model.dart';

enum ExportFormat {
  csv,
  encryptedJson,
}

class ExportService {
  final CryptoService _cryptoService;

  ExportService({CryptoService? cryptoService})
      : _cryptoService = cryptoService ?? CryptoService();

  Future<String> exportToCsv(List<KeyItemModel> items) async {
    final List<List<dynamic>> rows = [
      ['URL', 'UserName', 'Password', 'LinkURL', 'Note', 'PasswordLevel', 'IsFavorite', 'GroupID'],
    ];

    for (final item in items) {
      rows.add([
        item.url,
        item.username,
        item.password ?? '',
        item.linkUrl,
        item.note,
        item.passwordLevel,
        item.isFavorite,
        item.groupId ?? '',
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  Future<String> exportToEncryptedJson(
    List<KeyItemModel> items,
    String masterPassword,
  ) async {
    final itemsJson = items.map((item) => item.toJson()).toList();
    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'itemCount': items.length,
      'items': itemsJson,
    };

    final jsonString = jsonEncode(data);
    final encrypted = await _cryptoService.encryptString(jsonString, masterPassword);

    return jsonEncode({
      'format': 'encrypted_keybook_backup',
      'version': 1,
      'data': encrypted,
    });
  }

  Future<String> exportToPlainJson(List<KeyItemModel> items) async {
    final itemsJson = items.map((item) => item.toJson()).toList();
    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'itemCount': items.length,
      'items': itemsJson,
    };

    return const JsonEncoder.withIndent('  ').convert(data);
  }
}
