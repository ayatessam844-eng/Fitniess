import 'package:dartz/dartz.dart';
import 'package:fitnies/core/errors/exception_mapper.dart';
import 'package:fitnies/core/errors/failures.dart';
import 'package:fitnies/features/onboarding/data/datasources/local/onboarding_local_datasource.dart';
import 'package:fitnies/features/onboarding/domain/entities/onboarding_page_entity.dart';
import 'package:fitnies/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter/services.dart';

final class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, bool>> hasSeenOnboarding() async {
    try {
      return Right(_localDataSource.hasSeenOnboarding());
    } on PlatformException catch (exception) {
      return Left(mapPlatformExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, Unit>> completeOnboarding() async {
    try {
      await _localDataSource.completeOnboarding();
      return const Right(unit);
    } on PlatformException catch (exception) {
      return Left(mapPlatformExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, List<OnboardingPageEntity>>>
  getOnboardingPages() async {
    return Right(_localDataSource.getOnboardingPages());
  }
}
