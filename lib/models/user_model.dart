import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'is_active')
  final bool isActive;

  User({
    required this.id,
    required this.email,
    this.fullName,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String? message;
  final int? id;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? token;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  final String? jwt;
  final String? name;
  final String? username;

  AuthResponse({
    this.message,
    this.id,
    this.userId,
    this.token,
    this.accessToken,
    this.jwt,
    this.name,
    this.username,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => 
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
  
  int? get effectiveUserId => userId ?? id;
  String? get effectiveToken => token ?? accessToken ?? jwt;
  String? get effectiveName => name ?? username;
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => 
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  @JsonKey(name: 'full_name')
  final String? fullName;

  RegisterRequest({
    required this.email,
    required this.password,
    this.fullName,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => 
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class UserUpdateRequest {
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? password;

  UserUpdateRequest({
    this.fullName,
    this.password,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => 
      _$UserUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
