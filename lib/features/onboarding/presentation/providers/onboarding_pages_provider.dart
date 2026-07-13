import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/onboarding/domain/entities/onboarding_page_entity.dart';
import 'package:fitnies/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_pages_provider.g.dart';

@riverpod
Future<List<OnboardingPageEntity>> onboardingPages(
  OnboardingPagesRef ref,
) async {
  final useCase = await ref.watch(getOnboardingPagesUseCaseProvider.future);
  final result = await useCase(const NoParams());

  return result.fold((failure) => throw failure, (pages) => pages);
}
