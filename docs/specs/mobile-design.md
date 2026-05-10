# 移动端设计文档

本文档详细说明 KeyWordNoteBook 移动端的技术实现、设计决策和功能说明。

## 目录

- [项目概述](#项目概述)
- [技术架构](#技术架构)
- [核心模块实现](#核心模块实现)
- [功能模块说明](#功能模块说明)
- [状态管理](#状态管理)
- [安全实现](#安全实现)
- [测试策略](#测试策略)
- [性能优化](#性能优化)

---

## 项目概述

### 项目信息

| 项目 | 说明 |
|------|------|
| 项目名称 | KeyWordNoteBook Mobile |
| 目标平台 | iOS 12.0+ / Android 5.0+ |
| Flutter SDK | >= 3.0.0 |
| 状态 | 已完成开发 |

### 核心功能

| 功能 | 说明 | 实现状态 |
|------|------|---------|
| 用户认证 | 注册、登录、Token 管理 | ✅ |
| 密码管理 | CRUD 操作 | ✅ |
| 端到端加密 | AES-256-GCM | ✅ |
| 生物识别 | 指纹/面容解锁 | ✅ |
| 云端同步 | 增量同步 | ✅ |
| 离线支持 | 本地优先 | ✅ |

---

## 技术架构

### 架构模式

采用 **Clean Architecture** 分层架构：

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│                      (UI / Widgets)                          │
├─────────────────────────────────────────────────────────────┤
│                      Domain Layer                            │
│                  (Providers / Business Logic)                │
├─────────────────────────────────────────────────────────────┤
│                   Infrastructure Layer                       │
│                    (Services / Repositories)                   │
├─────────────────────────────────────────────────────────────┤
│                      Data Layer                              │
│                (Models / Network / Storage)                  │
└─────────────────────────────────────────────────────────────┘
```

### 技术选型

| 组件 | 技术方案 | 替代方案 | 选择理由 |
|------|---------|---------|---------|
| 框架 | Flutter 3.x | - | 跨平台一致性好 |
| 状态管理 | Riverpod | Provider | 编译时安全、测试友好 |
| HTTP | Dio | http 包 | 拦截器、连接复用 |
| 本地存储 | SQLite | Hive | 事务支持、类型安全 |
| 安全存储 | flutter_secure_storage | - | Keychain/Keystore |
| 生物识别 | local_auth | - | 官方维护 |
| 加密 | PointyCastle | cryptography | Dart 原生 |

### 依赖包

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  dio: ^5.4.0
  sqflite: ^2.3.0
  flutter_secure_storage: ^9.0.0
  local_auth: ^2.1.0
  pointycastle: ^3.7.0
  uuid: ^4.2.0
  json_annotation: ^4.8.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  json_serializable: ^6.7.0
  mockito: ^5.4.0
```

---

## 核心模块实现

### 1. 加密服务 (crypto)

#### 模块位置
`lib/core/crypto/`

#### 文件结构

```
crypto/
├── crypto_service.dart      # 服务入口，导出主要功能
├── aes_encryption.dart      # AES-256-GCM 加密实现
├── key_derivation.dart      # Argon2id 密钥派生
├── hmac_util.dart           # HMAC-SHA256 签名
├── password_strength.dart   # 密码强度评估
├── random_util.dart         # 随机数生成
├── argon2_params.dart       # Argon2 参数配置
└── crypto.dart              # 导出文件
```

#### 密钥派生流程

```dart
class KeyDerivation {
  /// 从主密码派生加密密钥
  /// 使用 Argon2id 算法
  Future<KeyPair> deriveKeys(String masterPassword, Uint8List salt) async {
    // 1. 生成盐 (如果未提供)
    final keySalt = salt ?? RandomUtil.generateSalt(32);

    // 2. Argon2id 派生加密密钥
    final encryptionKey = await Argon2.deriveKey(
      password: masterPassword,
      salt: keySalt,
      memory: 131072,  // 128 MB
      iterations: 6,
      parallelism: 6,
      keyLength: 32,
    );

    // 3. Argon2id 派生 HMAC 密钥
    final hmacKey = await Argon2.deriveKey(
      password: masterPassword,
      salt: Uint8List.fromList([...keySalt, 1]), // 不同的盐
      memory: 131072,
      iterations: 6,
      parallelism: 6,
      keyLength: 32,
    );

    return KeyPair(encryptionKey, hmacKey);
  }
}
```

#### AES-256-GCM 加密

```dart
class AesEncryption {
  /// 加密数据
  Future<EncryptedData> encrypt(
    Uint8List data,
    Uint8List key,
  ) async {
    // 1. 生成随机 IV (12 字节)
    final iv = RandomUtil.generateIV(12);

    // 2. 创建 cipher
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(key),
      128,  // tag length
      iv,
      Uint8List(0),
    );
    cipher.init(true, params);

    // 3. 加密
    final cipherText = cipher.process(data);

    return EncryptedData(cipherText, iv);
  }

  /// 解密数据
  Future<Uint8List> decrypt(
    EncryptedData encrypted,
    Uint8List key,
  ) async {
    final cipher = GCMBlockCipher(AESEngine());
    final params = AEADParameters(
      KeyParameter(key),
      128,
      encrypted.iv,
      Uint8List(0),
    );
    cipher.init(false, params);

    return cipher.process(encrypted.cipherText);
  }
}
```

#### 密码强度评估

```dart
class PasswordStrength {
  /// 评估密码强度
  /// 返回 0-4 的等级
  static int evaluate(String password) {
    int score = 0;

    // 长度检查
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (password.length >= 16) score++;

    // 复杂度检查
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    return (score / 2).clamp(0, 4).toInt();
  }
}
```

---

### 2. 网络服务 (network)

#### 模块位置
`lib/core/network/`

#### API 客户端封装

```dart
class ApiClient {
  final Dio _dio;
  final TokenManager _tokenManager;

  ApiClient({
    required String baseUrl,
    required TokenManager tokenManager,
  }) : _tokenManager = tokenManager {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // 添加拦截器
    _dio.interceptors.add(_AuthInterceptor(tokenManager));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

#### Token 管理

```dart
class TokenManager {
  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
```

---

### 3. 本地存储 (storage)

#### 模块位置
`lib/core/storage/`

#### 数据库结构

```dart
class LocalStorage {
  late Database _db;

  Future<void> init() async {
    _db = await openDatabase(
      'keyword_notebook.db',
      version: 1,
      onCreate: (db, version) async {
        // 密码条目表
        await db.execute('''
          CREATE TABLE key_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            url TEXT NOT NULL,
            username TEXT NOT NULL,
            password_encrypted TEXT NOT NULL,
            notes TEXT,
            password_level INTEGER DEFAULT 0,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            deleted_at TEXT,
            sync_status TEXT DEFAULT 'synced',
            version INTEGER DEFAULT 1
          )
        ''');

        // 待同步操作表
        await db.execute('''
          CREATE TABLE pending_operations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            item_index INTEGER,
            data TEXT,
            created_at TEXT NOT NULL
          )
        ''');

        // 设置表
        await db.execute('''
          CREATE TABLE settings (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
```

---

### 4. 同步服务 (sync)

#### 模块位置
`lib/core/sync/`

#### 同步状态

```dart
enum SyncStatus {
  idle,       // 空闲
  syncing,    // 同步中
  error,      // 错误
  offline,    // 离线
}

class SyncState {
  final SyncStatus status;
  final int localVersion;
  final int serverVersion;
  final bool isSyncing;
  final DateTime? lastSyncTime;

  SyncState copyWith({
    SyncStatus? status,
    int? localVersion,
    int? serverVersion,
    bool? isSyncing,
    DateTime? lastSyncTime,
  }) { ... }
}
```

#### 同步流程

```dart
class SyncService {
  final LocalStorage _storage;
  final ApiClient _apiClient;

  Future<void> sync() async {
    // 1. 获取当前状态
    final localVersion = await _storage.getSyncVersion();

    // 2. 检查服务端版本
    final serverStatus = await _apiClient.getSyncStatus(localVersion);

    if (serverStatus.hasUpdates) {
      // 3. 拉取服务端变更
      await _pullChanges(serverStatus.serverVersion);
    }

    // 4. 推送本地变更
    await _pushChanges();

    // 5. 更新本地版本
    await _storage.setSyncVersion(serverStatus.serverVersion);
  }

  Future<void> _pullChanges(int targetVersion) async {
    final changes = await _apiClient.pullChanges(
      await _storage.getSyncVersion(),
    );

    for (final op in changes.operations) {
      await _applyOperation(op);
    }
  }

  Future<void> _pushChanges() async {
    final pendingOps = await _storage.getPendingOperations();

    if (pendingOps.isNotEmpty) {
      await _apiClient.pushChanges(pendingOps);
      await _storage.clearPendingOperations();
    }
  }
}
```

---

### 5. 生物识别 (biometric)

#### 模块位置
`lib/core/biometric/`

#### 生物识别服务

```dart
class BiometricService {
  final LocalAuthentication _auth;

  /// 检查生物识别是否可用
  Future<bool> isAvailable() async {
    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final canAuthenticate = await _auth.isDeviceSupported();
    return canAuthenticateWithBiometrics && canAuthenticate;
  }

  /// 获取可用的生物识别类型
  Future<List<BiometricType>> getAvailableTypes() async {
    return await _auth.getAvailableBiometrics();
  }

  /// 执行生物识别认证
  Future<bool> authenticate({
    String reason = '请使用生物识别解锁',
  }) async {
    final isAvailable = await this.isAvailable();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
```

---

## 功能模块说明

### 认证模块 (auth)

#### 登录流程

```dart
class AuthRepository {
  final ApiClient _apiClient;
  final TokenManager _tokenManager;
  final CryptoService _cryptoService;

  Future<void> login(String email, String masterPassword) async {
    // 1. 调用登录 API
    final response = await _apiClient.post('/auth/login', data: {
      'email': email,
      'master_password': masterPassword,
    });

    // 2. 保存 Token
    await _tokenManager.saveTokens(
      accessToken: response['access_token'],
      refreshToken: response['refresh_token'],
    );

    // 3. 派生并保存加密密钥
    final salt = RandomUtil.generateSalt(32);
    final keys = await _cryptoService.deriveKeys(masterPassword, salt);
    await _cryptoService.saveKeys(keys);
  }
}
```

#### 登录界面

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(Icons.lock, size: 80),
              SizedBox(height: 24),

              // 邮箱输入
              TextField(
                decoration: InputDecoration(
                  labelText: '邮箱',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  ref.read(authProvider.notifier).setEmail(value);
                },
              ),
              SizedBox(height: 16),

              // 密码输入
              TextField(
                decoration: InputDecoration(
                  labelText: '主密码',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                onChanged: (value) {
                  ref.read(authProvider.notifier).setPassword(value);
                },
              ),
              SizedBox(height: 24),

              // 登录按钮
              ElevatedButton(
                onPressed: authState.isLoading
                    ? null
                    : () => _handleLogin(ref),
                child: authState.isLoading
                    ? CircularProgressIndicator()
                    : Text('登录'),
              ),

              // 注册链接
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('还没有账户？注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 主页模块 (home)

#### 密码列表

```dart
class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 加载密码列表
    Future.microtask(() {
      ref.read(keyBookProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyBookState = ref.watch(keyBookProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('密码本'),
        actions: [
          // 同步按钮
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () => _sync(ref),
          ),
          // 设置按钮
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索密码...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // 密码列表
          Expanded(
            child: _buildItemList(keyBookState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/item/new'),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemList(KeyBookState state) {
    if (state.isLoading && state.items.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(state.error!),
            ElevatedButton(
              onPressed: () => ref.read(keyBookProvider.notifier).loadItems(),
              child: Text('重试'),
            ),
          ],
        ),
      );
    }

    final items = ref.watch(filteredItemsProvider);

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('暂无密码条目', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('点击下方 + 按钮添加'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(keyBookProvider.notifier).loadItems(refresh: true),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _KeyItemCard(item: item);
        },
      ),
    );
  }
}
```

---

### 设置模块 (settings)

#### 设置界面

```dart
class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: ListView(
        children: [
          // 账户设置
          _SettingsSection(
            title: '账户',
            children: [
              _SettingsItem(
                icon: Icons.person,
                title: '个人信息',
                subtitle: ref.watch(authProvider).userInfo?.email,
              ),
              _SettingsItem(
                icon: Icons.lock,
                title: '修改密码',
                onTap: () { /* TODO */ },
              ),
              _SettingsItem(
                icon: Icons.fingerprint,
                title: '生物识别',
                subtitle: '使用指纹或面容快速解锁',
                trailing: Switch(
                  value: settings.biometricEnabled,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleBiometric();
                  },
                ),
              ),
            ],
          ),

          // 同步设置
          _SettingsSection(
            title: '同步',
            children: [
              _SettingsItem(
                icon: Icons.sync,
                title: '自动同步',
                trailing: Switch(
                  value: settings.autoSyncEnabled,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleAutoSync();
                  },
                ),
              ),
              _SettingsItem(
                icon: Icons.wifi,
                title: '仅在 Wi-Fi 下同步',
                trailing: Switch(
                  value: settings.wifiOnlySync,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleWifiOnlySync();
                  },
                ),
              ),
            ],
          ),

          // 安全设置
          _SettingsSection(
            title: '安全',
            children: [
              _SettingsItem(
                icon: Icons.timer,
                title: '自动锁定',
                subtitle: '${settings.autoLockMinutes} 分钟无操作后',
                onTap: () => _showAutoLockPicker(context, ref),
              ),
              _SettingsItem(
                icon: Icons.visibility_off,
                title: '隐藏密码',
                trailing: Switch(
                  value: settings.hidePasswords,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleHidePasswords();
                  },
                ),
              ),
            ],
          ),

          // 退出登录
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: () => _handleLogout(ref),
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text('退出登录', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 状态管理

### Riverpod Providers

```dart
// 认证状态
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() => AuthState.initial();

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repository.login(email, password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// 密码本状态
@riverpod
class KeyBook extends _$KeyBook {
  @override
  KeyBookState build() => KeyBookState.initial();

  Future<void> loadItems({bool refresh = false}) async {
    state = state.copyWith(isLoading: true);

    try {
      final items = await _repository.getItems();
      state = state.copyWith(
        isLoading: false,
        items: items,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// 设置状态
@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() {
    return SettingsState(
      biometricEnabled: false,
      autoSyncEnabled: true,
      wifiOnlySync: false,
      autoLockMinutes: 5,
      hidePasswords: true,
    );
  }

  void toggleBiometric() {
    state = state.copyWith(
      biometricEnabled: !state.biometricEnabled,
    );
    _saveSettings();
  }
}
```

---

## 安全实现

### 密钥管理

```dart
class SecureKeyStorage {
  final FlutterSecureStorage _secureStorage;

  static const _encryptionKeyKey = 'encryption_key';
  static const _hmacKeyKey = 'hmac_key';
  static const _saltKey = 'password_salt';

  /// 保存密钥（加密后）
  Future<void> saveKeys(KeyPair keys, Uint8List salt) async {
    await _secureStorage.write(key: _encryptionKeyKey, value: base64Encode(keys.encryptionKey));
    await _secureStorage.write(key: _hmacKeyKey, value: base64Encode(keys.hmacKey));
    await _secureStorage.write(key: _saltKey, value: base64Encode(salt));
  }

  /// 获取密钥
  Future<KeyPair?> getKeys() async {
    final encKeyStr = await _secureStorage.read(key: _encryptionKeyKey);
    final hmacKeyStr = await _secureStorage.read(key: _hmacKeyKey);

    if (encKeyStr == null || hmacKeyStr == null) return null;

    return KeyPair(
      base64Decode(encKeyStr),
      base64Decode(hmacKeyStr),
    );
  }

  /// 清除所有密钥
  Future<void> clearKeys() async {
    await _secureStorage.delete(key: _encryptionKeyKey);
    await _secureStorage.delete(key: _hmacKeyKey);
    await _secureStorage.delete(key: _saltKey);
  }
}
```

---

## 测试策略

### 单元测试

```dart
// test/core/crypto_service_test.dart

void main() {
  group('CryptoService', () {
    late CryptoService cryptoService;

    setUp(() {
      cryptoService = CryptoService();
    });

    test('should derive correct keys from password', () async {
      final password = 'test_password';
      final salt = RandomUtil.generateSalt(32);

      final keys = await cryptoService.deriveKeys(password, salt);

      expect(keys.encryptionKey.length, 32);
      expect(keys.hmacKey.length, 32);
    });

    test('should encrypt and decrypt data correctly', () async {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final key = RandomUtil.generateKey(32);

      final encrypted = await cryptoService.encrypt(data, key);
      final decrypted = await cryptoService.decrypt(encrypted, key);

      expect(decrypted, data);
    });

    test('should evaluate password strength correctly', () {
      expect(PasswordStrength.evaluate('weak'), 0);
      expect(PasswordStrength.evaluate('StrongPass123!'), 4);
    });
  });
}
```

### 集成测试

```dart
// test/core/settings_integration_test.dart

void main() {
  group('Settings Integration', () {
    testWidgets('should toggle biometric setting', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: SettingsScreen()),
        ),
      );

      // 找到生物识别开关
      final biometricSwitch = find.byType(Switch).first;
      expect(biometricSwitch, findsOneWidget);

      // 点击开关
      await tester.tap(biometricSwitch);
      await tester.pumpAndSettle();

      // 验证状态已更新
      final container = ProviderScope.containerOf(tester.element(biometricSwitch));
      final settings = container.read(settingsProvider);
      expect(settings.biometricEnabled, true);
    });
  });
}
```

---

## 性能优化

### 图片缓存

使用 `CachedNetworkImage` 缓存图标：

```dart
CachedNetworkImage(
  imageUrl: 'https://example.com/favicon.ico',
  placeholder: (context, url) => Icon(Icons.language),
  errorWidget: (context, url, error) => Icon(Icons.public),
);
```

### 列表优化

使用 `ListView.builder` 实现懒加载：

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return _KeyItemCard(item: items[index]);
  },
);
```

### 状态缓存

使用 `ref.watch` 配合 `select` 减少不必要的重建：

```dart
// 只在 items 变化时重建
final itemCount = ref.watch(keyBookProvider.select((s) => s.items.length));
```

---

## 下一步

- 查看 [架构设计](../architecture.md) 了解系统架构
- 查看 [开发指南](../development.md) 了解开发环境配置
- 查看 [后端 API](../server/README.md) 了解 API 设计
