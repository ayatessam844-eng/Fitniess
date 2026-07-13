import 'package:dio/dio.dart';
import 'package:fitnies/core/constants/api_endpoints.dart';
import 'package:fitnies/features/auth/data/models/login_request_model.dart';
import 'package:fitnies/features/auth/data/models/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @POST(ApiEndpoints.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}
