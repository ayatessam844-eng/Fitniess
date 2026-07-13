import 'package:dio/dio.dart';
import 'package:fitnies/core/constants/app_constants.dart';
import 'package:fitnies/core/network/auth_interceptor.dart';
import 'package:fitnies/core/storage/secure_storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: const {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(ref.watch(secureStorageServiceProvider)),
  );
  dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  return dio;
}
