import 'package:fitnies/features/auth/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
final class LoginResponseModel {
  const LoginResponseModel({required this.token, required this.user});

  final String token;
  final UserModel user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
