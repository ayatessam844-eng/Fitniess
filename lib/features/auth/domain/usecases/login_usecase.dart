import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/auth/domain/entities/user_entity.dart';
import 'package:fitnies/features/auth/domain/repositories/auth_repository.dart';

final class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return _repository.login(params);
  }
}

final class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
