import 'package:fitnies/core/storage/local_preferences_service.dart';
import 'package:fitnies/features/onboarding/data/models/onboarding_page_model.dart';

class OnboardingLocalDataSource {
  const OnboardingLocalDataSource(this._preferencesService);

  final LocalPreferencesService _preferencesService;

  bool hasSeenOnboarding() {
    return _preferencesService.hasSeenOnboarding;
  }

  Future<bool> completeOnboarding() {
    return _preferencesService.setHasSeenOnboarding(true);
  }

  List<OnboardingPageModel> getOnboardingPages() {
    return const [
      OnboardingPageModel(
        title: 'Train with purpose',
        description: 'Build simple routines that match your goals and energy.',
        imageAsset: 'assets/svg/logoSplash.svg',
      ),
      OnboardingPageModel(
        title: 'Track every step',
        description: 'Keep your progress visible from the first workout.',
        imageAsset: 'assets/svg/logoSplash.svg',
      ),
      OnboardingPageModel(
        title: 'Ask smarter questions',
        description: 'Use AI chat to explore workouts, recovery, and habits.',
        imageAsset: 'assets/svg/logoSplash.svg',
      ),
    ];
  }
}
