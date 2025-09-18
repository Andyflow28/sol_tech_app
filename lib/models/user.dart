class User {
  final int userId;
  final String email;
  final String username;
  final String fullName;
  final bool hasStation;

  User({
    required this.userId,
    required this.email,
    required this.username,
    required this.fullName,
    required this.hasStation,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      username: json['username'],
      fullName: json['full_name'],
      hasStation: json['has_station'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'username': username,
      'full_name': fullName,
      'has_station': hasStation,
    };
  }
}

class UserCreate {
  final String email;
  final String username;
  final String fullName;
  final String password;

  UserCreate({
    required this.email,
    required this.username,
    required this.fullName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'full_name': fullName,
      'password': password,
    };
  }
}