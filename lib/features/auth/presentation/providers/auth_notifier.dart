import 'package:easy_localization/easy_localization.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/auth/domain/entities/user_entity.dart';
import 'package:fitnies/features/auth/domain/usecases/login_usecase.dart';
import 'package:fitnies/features/auth/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserEntity?> build() async {
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await ref.read(loginUseCaseProvider)(
      LoginParams(email: email, password: password),
    );

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (user) => AsyncData(user),
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    final result = await ref.read(logoutUseCaseProvider)(const NoParams());

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

extension AuthFailureMessage on Object {
  String get authDisplayMessage {
    final error = this;
    if (error is Failure) {
      return error.message;
    }
    return 'auth.login_failed'.tr();
  }
}
