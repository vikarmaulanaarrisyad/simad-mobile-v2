class LoginRequest {
  final String token;
  final String message;

  LoginRequest({required this.token, required this.message});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      token: json['token'],
      message: json['message'],
    );
  }
}
