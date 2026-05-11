class UserModel {
  final String username;
  final String email;
  final String token;
  final String password;
  final String role;
  final String address;
  final String phoneNumber;
  final String? refreshToken;
  final String id;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    required this.password,
    required this.role,
    required this.address,
    required this.phoneNumber,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] = '',
      email: json['email'] = '',
      token: json['token'] = '',
      password: json['password'] = '',
      role: json['role'] = '',
      address: json['address'] = '',
      phoneNumber: json['phoneNumber'] = '',
      refreshToken: json['refreshToken'] = '',
    );
  }
}
