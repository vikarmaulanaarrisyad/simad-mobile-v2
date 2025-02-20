class LoginResponseError {
  final String message;

  LoginResponseError({required this.message});

  factory LoginResponseError.fromJson(Map<String, dynamic> json) {
    return LoginResponseError(
      message: json['message'],
    );
  }
}
