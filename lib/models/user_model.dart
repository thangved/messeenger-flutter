class UserModel {
  final String id;

  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final String username;

  final bool friend;
  final bool requested;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.username,
    required this.friend,
    required this.requested,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      avatar: json['avatar'],
      username: json['username'],
      friend: json['friend'] ?? false,
      requested: json['requested'] ?? false,
    );
  }
}
