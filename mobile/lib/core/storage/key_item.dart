class KeyItem {
  final String index;
  final String url;
  final String username;
  final String password;
  final String? linkUrl;
  final String? note;

  KeyItem({
    required this.index,
    required this.url,
    required this.username,
    required this.password,
    this.linkUrl,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'url': url,
      'username': username,
      'password': password,
      'linkUrl': linkUrl,
      'note': note,
    };
  }

  factory KeyItem.fromMap(Map<String, dynamic> map) {
    return KeyItem(
      index: map['index'] as String,
      url: map['url'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      linkUrl: map['linkUrl'] as String?,
      note: map['note'] as String?,
    );
  }
}
