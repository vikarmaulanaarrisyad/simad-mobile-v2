part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess({required this.token});
}

class AuthGetUser extends AuthState {
  final String token;
  final User user;
  AuthGetUser({required this.token, required this.user});
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

class AuthPasswordVisibility extends AuthState {
  final bool isPasswordVisible;
  AuthPasswordVisibility({required this.isPasswordVisible});
}
