import 'package:dartz/dartz.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/onboarding/domain/repositories/onboarding_repository.dart';

final class CheckOnboardingStatusUseCase implements UseCase<bool, NoParams> {
  const CheckOnboardingStatusUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.hasSeenOnboarding();
  }
}
