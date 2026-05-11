import 'package:http/http.dart' as http;
import 'package:car_rental/features/auth/models/user_model.dart';
import 'dart:convert';

class AuthService {
  Future<UserModel> register({
    required String username,
    required String email,
    required String token,
    required String password,
    required String role,
    required String address,
    required String phoneNumber,
  }) async {
    final response = await http.post(
      Uri.parse('http://**'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'token': token,
        'password': password,
        'role': role,
        'address': address,
        'phoneNumber': phoneNumber,
      }),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://**'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
