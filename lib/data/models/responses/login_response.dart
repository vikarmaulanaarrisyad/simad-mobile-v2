import 'dart:convert';

class LoginResponse {
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  // Konversi dari JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json["message"],
      token: json["token"],
      user: User.fromJson(json["user"]),
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "token": token,
      "user": user.toJson(),
    };
  }

  // Konversi dari String JSON
  static LoginResponse fromJsonString(String jsonString) {
    return LoginResponse.fromJson(json.decode(jsonString));
  }

  // Konversi ke String JSON
  String toJsonString() {
    return json.encode(toJson());
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorConfirmedAt;
  final String foto;
  final dynamic currentTeamId;
  final dynamic profilePhotoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.twoFactorConfirmedAt,
    required this.foto,
    required this.currentTeamId,
    required this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  // Konversi dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      twoFactorConfirmedAt: json["two_factor_confirmed_at"],
      foto: json["foto"],
      currentTeamId: json["current_team_id"],
      profilePhotoPath: json["profile_photo_path"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      profilePhotoUrl: json["profile_photo_url"],
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "two_factor_confirmed_at": twoFactorConfirmedAt,
      "foto": foto,
      "current_team_id": currentTeamId,
      "profile_photo_path": profilePhotoPath,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "profile_photo_url": profilePhotoUrl,
    };
  }
}
