import 'package:dio/dio.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:flutter/services.dart';

Failure mapDioExceptionToFailure(DioException exception) {
  final statusCode = exception.response?.statusCode;
  final message = _extractMessage(exception);

  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.sendTimeout ||
      exception.type == DioExceptionType.connectionError) {
    return NetworkFailure(message, statusCode: statusCode);
  }

  if (statusCode == 401 || statusCode == 403) {
    return UnauthorizedFailure(message, statusCode: statusCode);
  }

  if (statusCode == 400 || statusCode == 422) {
    return ValidationFailure(message, statusCode: statusCode);
  }

  return ServerFailure(message, statusCode: statusCode);
}

Failure mapPlatformExceptionToFailure(PlatformException exception) {
  return CacheFailure(exception.message ?? 'Local storage error');
}

String _extractMessage(DioException exception) {
  final data = exception.response?.data;
  if (data is Map<String, dynamic>) {
    final message = data['message'] ?? data['error'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }
  }

  if (exception.message case final message? when message.trim().isNotEmpty) {
    return message;
  }

  return 'Something went wrong';
}
