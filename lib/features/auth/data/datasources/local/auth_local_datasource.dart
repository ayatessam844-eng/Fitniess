import 'package:fitnies/core/storage/secure_storage_service.dart';

class AuthLocalDataSource {
  const AuthLocalDataSource(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  Future<String?> readToken() {
    return _secureStorageService.readAuthToken();
  }

  Future<void> saveToken(String token) {
    return _secureStorageService.writeAuthToken(token);
  }

  Future<void> clearToken() {
    return _secureStorageService.deleteAuthToken();
  }
}
