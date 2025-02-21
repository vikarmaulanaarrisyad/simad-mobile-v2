import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simad_mobile_v2/core/constants/app.dart';
import 'package:simad_mobile_v2/data/models/requests/login_request.dart';
import 'package:simad_mobile_v2/data/models/responses/login_response.dart';

class AuthRepository {
  final Dio _dio = Dio();
  final String baseUrl = App.devUrl; // Ganti dengan URL Laravel Anda

  Future<LoginRequest> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "$baseUrl/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return LoginRequest.fromJson(response.data);
      } else {
        throw Exception("Login gagal! Periksa kembali email dan password.");
      }
    } on DioException catch (e) {
      // Tangkap error dari API Laravel
      String errorMessage = '${e.message}';

      if (e.response != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey("message")) {
          errorMessage = responseData["message"];
        } else if (e.response!.statusCode == 401) {
          errorMessage = "Email atau password salah.";
        } else if (e.response!.statusCode == 500) {
          errorMessage = "Terjadi kesalahan pada server.";
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Koneksi timeout. Periksa jaringan Anda.";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Server tidak merespons. Coba lagi nanti.";
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = "Gagal terhubung ke server.";
      }
      throw Exception(errorMessage);
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

// mendaptkan data user
  Future<LoginResponse> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token tidak ditemukan. Silakan login kembali.");
    }

    try {
      final response = await _dio.get(
        "$baseUrl/user",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception("Gagal mendapatkan data user.");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Jika token expired, hapus dari storage
        await prefs.remove("token");
        throw Exception("Sesi telah berakhir. Silakan login kembali.");
      }
      throw Exception(e.response?.data["message"] ?? "Gagal mendapatkan user.");
    }
  }
}
