import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitnies/core/errors/exception_mapper.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:fitnies/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:fitnies/features/auth/data/models/login_request_model.dart';
import 'package:fitnies/features/auth/domain/entities/user_entity.dart';
import 'package:fitnies/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitnies/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/services.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestModel(email: params.email, password: params.password),
      );
      await _localDataSource.saveToken(response.token);
      return Right(response.user);
    } on DioException catch (exception) {
      return Left(mapDioExceptionToFailure(exception));
    } on PlatformException catch (exception) {
      return Left(mapPlatformExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _localDataSource.clearToken();
      return const Right(unit);
    } on PlatformException catch (exception) {
      return Left(mapPlatformExceptionToFailure(exception));
    }
  }
}
