import 'package:fitnies/core/constants/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> readAuthToken() {
    return _storage.read(key: AppConstants.authTokenKey);
  }

  Future<void> writeAuthToken(String token) {
    return _storage.write(key: AppConstants.authTokenKey, value: token);
  }

  Future<void> deleteAuthToken() {
    return _storage.delete(key: AppConstants.authTokenKey);
  }
}

@riverpod
FlutterSecureStorage flutterSecureStorage(FlutterSecureStorageRef ref) {
  return const FlutterSecureStorage();
}

@riverpod
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService(ref.watch(flutterSecureStorageProvider));
}
