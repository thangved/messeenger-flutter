class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final String username;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      avatar: json['avatar'],
      username: json['username'],
    );
  }
}
