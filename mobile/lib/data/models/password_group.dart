/// 密码分组模型
class PasswordGroup {
  final String id;
  final String name;
  final int itemCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  PasswordGroup({
    required this.id,
    required this.name,
    this.itemCount = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory PasswordGroup.fromJson(Map<String, dynamic> json) {
    return PasswordGroup(
      id: json['id']?.toString() ?? json['Id']?.toString() ?? '',
      name: json['name'] ?? json['Name'] ?? '',
      itemCount: json['item_count'] ?? json['itemCount'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'item_count': itemCount,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  PasswordGroup copyWith({
    String? id,
    String? name,
    int? itemCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PasswordGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      itemCount: itemCount ?? this.itemCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordGroup &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
