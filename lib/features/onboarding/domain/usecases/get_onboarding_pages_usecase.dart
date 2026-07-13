import 'package:dartz/dartz.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/core/usecase/usecase.dart';
import 'package:fitnies/features/onboarding/domain/entities/onboarding_page_entity.dart';
import 'package:fitnies/features/onboarding/domain/repositories/onboarding_repository.dart';

final class GetOnboardingPagesUseCase
    implements UseCase<List<OnboardingPageEntity>, NoParams> {
  const GetOnboardingPagesUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, List<OnboardingPageEntity>>> call(NoParams params) {
    return _repository.getOnboardingPages();
  }
}
