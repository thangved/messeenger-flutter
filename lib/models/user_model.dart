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
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.avatar = "",
    this.username = "",
    this.friend = false,
    this.requested = false,
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
