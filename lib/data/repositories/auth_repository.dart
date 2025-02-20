import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simad_mobile_v2/data/models/responses/login_response.dart';

class AuthRepository {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://your-api.com/api"; // Ganti dengan URL Laravel Anda

  Future<LoginResponse> login(String email, String password) async {
    final response = await _dio.post(
      "$baseUrl/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception("Login failed");
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}
