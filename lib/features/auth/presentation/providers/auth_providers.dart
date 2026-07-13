import 'package:fitnies/core/network/dio_provider.dart';
import 'package:fitnies/core/storage/secure_storage_service.dart';
import 'package:fitnies/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:fitnies/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:fitnies/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitnies/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitnies/features/auth/domain/usecases/login_usecase.dart';
import 'package:fitnies/features/auth/domain/usecases/logout_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSource(ref.watch(secureStorageServiceProvider));
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}
