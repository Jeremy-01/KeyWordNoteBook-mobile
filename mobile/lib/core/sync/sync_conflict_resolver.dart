import '../storage/key_item.dart';

enum ConflictStrategy {
  serverWins,
  clientWins,
  lastWriteWins,
}

class ConflictPair {
  final String itemIndex;
  final KeyItem local;
  final KeyItem server;

  ConflictPair({
    required this.itemIndex,
    required this.local,
    required this.server,
  });
}

class SyncConflictResolver {
  ConflictStrategy _defaultStrategy = ConflictStrategy.serverWins;

  ConflictStrategy get defaultStrategy => _defaultStrategy;

  List<ConflictStrategy> get supportedStrategies => ConflictStrategy.values;

  void setStrategy(ConflictStrategy strategy) {
    _defaultStrategy = strategy;
  }

  bool hasConflict(KeyItem local, KeyItem server) {
    return local.url != server.url ||
        local.username != server.username ||
        local.password != server.password ||
        local.linkUrl != server.linkUrl;
  }

  KeyItem resolve(KeyItem local, KeyItem server) {
    switch (_defaultStrategy) {
      case ConflictStrategy.serverWins:
        return _mergeItems(server, local);
      case ConflictStrategy.clientWins:
        return _mergeItems(local, server);
      case ConflictStrategy.lastWriteWins:
        return hasConflict(local, server) ? server : local;
    }
  }

  KeyItem _mergeItems(KeyItem primary, KeyItem secondary) {
    return KeyItem(
      index: primary.index,
      url: primary.url,
      username: primary.username,
      password: primary.password,
      linkUrl: primary.linkUrl ?? secondary.linkUrl,
      note: primary.note ?? secondary.note,
    );
  }

  List<KeyItem> resolveAll(List<ConflictPair> conflicts) {
    return conflicts.map((pair) => resolve(pair.local, pair.server)).toList();
  }
}
