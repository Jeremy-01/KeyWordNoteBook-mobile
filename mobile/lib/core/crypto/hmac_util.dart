/// HMAC 工具类
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// HMAC 工具
class HmacUtil {
  HmacUtil._();

  /// 计算 HMAC-SHA256
  ///
  /// [data] 数据映射
  /// [key] 密钥
  ///
  /// 返回：64 字符十六进制字符串
  static String compute(Map<String, dynamic> data, Uint8List key) {
    // 规范化数据
    final canonical = _canonicalize(data);
    final bytes = utf8.encode(canonical);

    // 计算 HMAC
    final hmac = HMac(SHA256Digest(), 64)
      ..init(KeyParameter(key));

    final result = hmac.process(Uint8List.fromList(bytes));

    // 转换为十六进制
    return result.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// 验证 HMAC
  static bool verify(Map<String, dynamic> data, Uint8List key, String expected) {
    final computed = compute(data, key);
    return _constantTimeEquals(computed, expected);
  }

  /// 规范化数据（按键排序）
  static String _canonicalize(Map<String, dynamic> data) {
    final sorted = Map.fromEntries(
      data.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return jsonEncode(sorted);
  }

  /// 固定时间比较
  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
