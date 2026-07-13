import 'package:dartz/dartz.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/features/auth/domain/entities/user_entity.dart';
import 'package:fitnies/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, Unit>> logout();
}
