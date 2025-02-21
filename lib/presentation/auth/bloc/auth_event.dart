part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class LogoutRequested extends AuthEvent {}

class TogglePasswordVisibility extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {} // Cek token saat aplikasi dimulai

// Event untuk mendapatkan user dari API
class GetUserRequested extends AuthEvent {} // Event untuk mengambil user
