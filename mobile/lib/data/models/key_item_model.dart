/// 密码条目模型
class KeyItemModel {
  final String index;
  final String url;
  final String username;
  final String? password;
  final int passwordLevel;
  final String linkUrl;
  final String note;
  final bool isFavorite;
  final String? groupId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  KeyItemModel({
    required this.index,
    required this.url,
    required this.username,
    this.password,
    required this.passwordLevel,
    required this.linkUrl,
    required this.note,
    this.isFavorite = false,
    this.groupId,
    this.createdAt,
    this.updatedAt,
  });

  factory KeyItemModel.fromJson(Map<String, dynamic> json) {
    return KeyItemModel(
      index: json['index']?.toString() ?? json['Index']?.toString() ?? '',
      url: json['url'] ?? json['URL'] ?? '',
      username: json['username'] ?? json['UserName'] ?? '',
      password: json['password'] ?? json['Password'],
      passwordLevel: json['password_level'] ?? json['PasswordLevel'] ?? 0,
      linkUrl: json['link_url'] ?? json['LinkURL'] ?? '',
      note: json['note'] ?? json['Note'] ?? '',
      isFavorite: json['is_favorite'] ?? json['isFavorite'] ?? false,
      groupId: json['group_id'] ?? json['groupId'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'url': url,
    'username': username,
    if (password != null) 'password': password,
    'password_level': passwordLevel,
    'link_url': linkUrl,
    'note': note,
    'is_favorite': isFavorite,
    if (groupId != null) 'group_id': groupId,
  };

  KeyItemModel copyWith({
    String? index,
    String? url,
    String? username,
    String? password,
    int? passwordLevel,
    String? linkUrl,
    String? note,
    bool? isFavorite,
    String? groupId,
  }) {
    return KeyItemModel(
      index: index ?? this.index,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordLevel: passwordLevel ?? this.passwordLevel,
      linkUrl: linkUrl ?? this.linkUrl,
      note: note ?? this.note,
      isFavorite: isFavorite ?? this.isFavorite,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyItemModel &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}
