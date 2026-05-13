import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'key_item.dart';
import 'pending_operation.dart';

class LocalStorage {
  Database? _database;
  final String _databaseName;
  bool _isInitialized = false;

  LocalStorage({String databaseName = 'keybook.db'})
      : _databaseName = databaseName;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    _isInitialized = true;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        "index" TEXT PRIMARY KEY,
        url TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        linkUrl TEXT,
        note TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sync_meta (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE pending_operations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        itemIndex TEXT NOT NULL,
        data TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
    _isInitialized = false;
  }

  Future<void> clearAllItems() async {
    await _database?.delete('items');
  }

  Future<void> insertItem(KeyItem item) async {
    await _database?.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertItems(List<KeyItem> items) async {
    final batch = _database?.batch();
    for (final item in items) {
      batch?.insert(
        'items',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch?.commit(noResult: true);
  }

  Future<List<KeyItem>> getAllItems() async {
    final maps = await _database?.query('items') ?? [];
    return maps.map((map) => KeyItem.fromMap(map)).toList();
  }

  Future<KeyItem?> getItemByIndex(String index) async {
    final maps = await _database?.query(
      'items',
      where: '"index" = ?',
      whereArgs: [index],
    );
    if (maps == null || maps.isEmpty) return null;
    return KeyItem.fromMap(maps.first);
  }

  Future<void> updateItem(KeyItem item) async {
    await _database?.update(
      'items',
      item.toMap(),
      where: '"index" = ?',
      whereArgs: [item.index],
    );
  }

  Future<void> deleteItem(String index) async {
    await _database?.delete(
      'items',
      where: '"index" = ?',
      whereArgs: [index],
    );
  }

  Future<List<KeyItem>> searchItems(String query) async {
    final maps = await _database?.query(
      'items',
      where: 'url LIKE ? OR username LIKE ? OR note LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    ) ?? [];
    return maps.map((map) => KeyItem.fromMap(map)).toList();
  }

  Future<int> getSyncVersion() async {
    final result = await _database?.query(
      'sync_meta',
      where: 'key = ?',
      whereArgs: ['version'],
    );
    if (result == null || result.isEmpty) return 0;
    return int.tryParse(result.first['value'] as String) ?? 0;
  }

  Future<void> saveSyncVersion(int version) async {
    await _database?.insert(
      'sync_meta',
      {'key': 'version', 'value': version.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DateTime?> getLastSyncTime() async {
    final result = await _database?.query(
      'sync_meta',
      where: 'key = ?',
      whereArgs: ['lastSyncTime'],
    );
    if (result == null || result.isEmpty) return null;
    return DateTime.tryParse(result.first['value'] as String);
  }

  Future<void> saveLastSyncTime(DateTime time) async {
    await _database?.insert(
      'sync_meta',
      {'key': 'lastSyncTime', 'value': time.toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addPendingOperation(PendingOperation op) async {
    await _database?.insert('pending_operations', {
      'type': op.type,
      'itemIndex': op.itemIndex,
      'data': jsonEncode(op.data),
      'createdAt': op.createdAt.toIso8601String(),
    });
  }

  Future<List<PendingOperation>> getPendingOperations() async {
    final maps = await _database?.query('pending_operations') ?? [];
    return maps.map((map) {
      return PendingOperation(
        type: map['type'] as String,
        itemIndex: map['itemIndex'] as String,
        data: jsonDecode(map['data'] as String) as Map<String, dynamic>,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
    }).toList();
  }

  Future<void> removePendingOperation(String itemIndex, String type) async {
    await _database?.delete(
      'pending_operations',
      where: 'itemIndex = ? AND type = ?',
      whereArgs: [itemIndex, type],
    );
  }

  Future<void> clearPendingOperations() async {
    await _database?.delete('pending_operations');
  }
}
