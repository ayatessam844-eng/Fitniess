import 'package:dartz/dartz.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/features/onboarding/domain/entities/onboarding_page_entity.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, bool>> hasSeenOnboarding();
  Future<Either<Failure, Unit>> completeOnboarding();
  Future<Either<Failure, List<OnboardingPageEntity>>> getOnboardingPages();
}
