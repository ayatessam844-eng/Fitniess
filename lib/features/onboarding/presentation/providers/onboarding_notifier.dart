import 'package:easy_localization/easy_localization.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifier.g.dart';

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  Future<bool> build() async {
    final useCase = await ref.watch(
      checkOnboardingStatusUseCaseProvider.future,
    );
    final result = await useCase(const NoParams());

    return result.fold((failure) => throw failure, (hasSeen) => hasSeen);
  }

  Future<void> complete() async {
    state = const AsyncLoading();

    final useCase = await ref.read(completeOnboardingUseCaseProvider.future);
    final result = await useCase(const NoParams());

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (_) => const AsyncData(true),
    );
  }
}

extension OnboardingFailureMessage on Object {
  String get onboardingDisplayMessage {
    final error = this;
    if (error is Failure) {
      return error.message;
    }
    return 'onboarding.update_failed'.tr();
  }
}
