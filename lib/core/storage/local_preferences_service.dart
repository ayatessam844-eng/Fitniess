import 'package:fitnies/core/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_preferences_service.g.dart';

class LocalPreferencesService {
  LocalPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  bool get hasSeenOnboarding {
    return _preferences.getBool(AppConstants.hasSeenOnboardingKey) ?? false;
  }

  Future<bool> setHasSeenOnboarding(bool value) {
    return _preferences.setBool(AppConstants.hasSeenOnboardingKey, value);
  }
}

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}

@riverpod
Future<LocalPreferencesService> localPreferencesService(
  LocalPreferencesServiceRef ref,
) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return LocalPreferencesService(preferences);
}
