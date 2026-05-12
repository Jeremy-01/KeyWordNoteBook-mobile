/// API 客户端测试 - TDD 方式
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/core/network/api_exception.dart';
import 'package:keybook/core/network/api_response.dart';
import 'package:keybook/core/network/token_manager.dart';
import 'package:keybook/data/models/auth_models.dart';
import 'package:keybook/data/models/key_item_model.dart';

import '../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('ApiResponse - 响应模型', () {
    test('成功响应应该正确解析 code=0', () {
      final json = {'code': 0, 'message': 'success', 'data': {'token': 'abc123'}};

      final response = ApiResponse<Map<String, dynamic>>(
        code: json['code'] as int,
        message: json['message'] as String,
        data: json['data'] as Map<String, dynamic>,
      );

      expect(response.code, equals(0));
      expect(response.isSuccess, isTrue);
      expect(response.data, isNotNull);
      expect(response.data!['token'], equals('abc123'));
    });

    test('错误响应应该正确解析 code!=0', () {
      final response = ApiResponse<Map<String, dynamic>>(
        code: 1002,
        message: '认证失败',
        data: null,
      );

      expect(response.code, equals(1002));
      expect(response.isSuccess, isFalse);
      expect(response.message, equals('认证失败'));
    });
  });

  group('KeyItemModel - 密码条目模型', () {
    test('fromJson 应该正确解析列表响应', () {
      final json = {
        'index': '1',
        'url': 'https://github.com',
        'username': 'testuser',
        'password_level': 4,
        'link_url': '',
        'note': 'GitHub 账号',
      };

      final item = KeyItemModel.fromJson(json);

      expect(item.index, equals('1'));
      expect(item.url, equals('https://github.com'));
      expect(item.username, equals('testuser'));
      expect(item.passwordLevel, equals(4));
      expect(item.note, equals('GitHub 账号'));
    });

    test('fromJson 应该解析详情响应（含密码）', () {
      final json = {
        'index': '1',
        'url': 'https://github.com',
        'username': 'testuser',
        'password': 'MySecretPassword!',
        'password_level': 4,
        'link_url': '',
        'note': 'GitHub 账号',
      };

      final item = KeyItemModel.fromJson(json);

      expect(item.password, equals('MySecretPassword!'));
    });

    test('toJson 应该正确序列化', () {
      final item = KeyItemModel(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        password: 'secret',
        passwordLevel: 3,
        linkUrl: '',
        note: 'Test',
      );

      final json = item.toJson();

      expect(json['index'], equals('1'));
      expect(json['url'], equals('https://github.com'));
      expect(json['username'], equals('testuser'));
    });

    test('copyWith 应该正确复制', () {
      final item = KeyItemModel(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordLevel: 3,
        linkUrl: '',
        note: 'Test',
      );

      final copied = item.copyWith(note: 'Updated');

      expect(copied.index, equals('1'));
      expect(copied.note, equals('Updated'));
    });
  });

  group('AuthResponse - 认证响应', () {
    test('fromJson 应该正确解析登录响应', () {
      final json = {
        'access_token': 'eyJhbGc...',
        'refresh_token': 'eyJhbGc...',
        'expires_in': 3600,
        'token_type': 'Bearer',
      };

      final auth = AuthResponse.fromJson(json);

      expect(auth.accessToken, equals('eyJhbGc...'));
      expect(auth.refreshToken, equals('eyJhbGc...'));
      expect(auth.expiresIn, equals(3600));
      expect(auth.tokenType, equals('Bearer'));
    });

    test('expiresAt 应该正确计算过期时间', () {
      final auth = AuthResponse(
        accessToken: 'access',
        refreshToken: 'refresh',
        expiresIn: 3600,
      );

      final expectedExpiry = DateTime.now().add(const Duration(seconds: 3600));
      final actualExpiry = auth.expiresAt;

      expect((actualExpiry.difference(expectedExpiry).inSeconds).abs(), lessThan(2));
    });
  });

  group('RegisterRequest - 注册请求', () {
    test('toJson 应该正确序列化', () {
      final request = RegisterRequest(
        email: 'test@example.com',
        password: 'P@ss123!',
        passwordConfirm: 'P@ss123!',
      );

      final json = request.toJson();

      expect(json['email'], equals('test@example.com'));
      expect(json['password'], equals('P@ss123!'));
      expect(json['password_confirm'], equals('P@ss123!'));
    });
  });

  group('ApiException - 异常处理', () {
    test('ApiException 应该正确创建', () {
      final exception = ApiException(
        code: 401,
        message: 'Unauthorized',
        statusCode: 401,
      );

      expect(exception.code, equals(401));
      expect(exception.message, equals('Unauthorized'));
      expect(exception.statusCode, equals(401));
    });

    test('ApiException.toString 应该包含详细信息', () {
      final exception = ApiException(
        code: 1002,
        message: 'Token 已过期',
        statusCode: 401,
      );

      final str = exception.toString();

      expect(str, contains('1002'));
      expect(str, contains('Token 已过期'));
    });
  });
}
