class User {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
  });

  String get displayLabel => displayName?.isNotEmpty == true ? displayName! : email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? json['userId']?.toString() ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String? ?? json['picture'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  String toString() => 'User(id: $id, email: $email, displayName: $displayName)';
}
