import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
final class LoginRequestModel {
  const LoginRequestModel({required this.email, required this.password});

  final String email;
  final String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
