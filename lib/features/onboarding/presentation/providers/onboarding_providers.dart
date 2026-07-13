import 'package:fitnies/core/storage/local_preferences_service.dart';
import 'package:fitnies/features/onboarding/data/datasources/local/onboarding_local_datasource.dart';
import 'package:fitnies/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:fitnies/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fitnies/features/onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:fitnies/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:fitnies/features/onboarding/domain/usecases/get_onboarding_pages_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_providers.g.dart';

@riverpod
Future<OnboardingLocalDataSource> onboardingLocalDataSource(
  OnboardingLocalDataSourceRef ref,
) async {
  final preferencesService = await ref.watch(
    localPreferencesServiceProvider.future,
  );
  return OnboardingLocalDataSource(preferencesService);
}

@riverpod
Future<OnboardingRepository> onboardingRepository(
  OnboardingRepositoryRef ref,
) async {
  final localDataSource = await ref.watch(
    onboardingLocalDataSourceProvider.future,
  );
  return OnboardingRepositoryImpl(localDataSource);
}

@riverpod
Future<CheckOnboardingStatusUseCase> checkOnboardingStatusUseCase(
  CheckOnboardingStatusUseCaseRef ref,
) async {
  final repository = await ref.watch(onboardingRepositoryProvider.future);
  return CheckOnboardingStatusUseCase(repository);
}

@riverpod
Future<CompleteOnboardingUseCase> completeOnboardingUseCase(
  CompleteOnboardingUseCaseRef ref,
) async {
  final repository = await ref.watch(onboardingRepositoryProvider.future);
  return CompleteOnboardingUseCase(repository);
}

@riverpod
Future<GetOnboardingPagesUseCase> getOnboardingPagesUseCase(
  GetOnboardingPagesUseCaseRef ref,
) async {
  final repository = await ref.watch(onboardingRepositoryProvider.future);
  return GetOnboardingPagesUseCase(repository);
}
