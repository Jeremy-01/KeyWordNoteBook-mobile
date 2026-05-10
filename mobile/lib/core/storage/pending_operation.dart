class PendingOperation {
  final String type;
  final String itemIndex;
  final Map<String, dynamic> data;
  final DateTime createdAt;

  PendingOperation({
    required this.type,
    required this.itemIndex,
    required this.data,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'itemIndex': itemIndex,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PendingOperation.fromMap(Map<String, dynamic> map) {
    return PendingOperation(
      type: map['type'] as String,
      itemIndex: map['itemIndex'] as String,
      data: Map<String, dynamic>.from(map['data'] as Map),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
