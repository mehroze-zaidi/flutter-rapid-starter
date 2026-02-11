import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Singleton wrapping [FlutterSecureStorage] for encrypted key-value persistence.
///
/// Usage:
///   await SecureStorageService.instance.write(StorageKeys.onboardingCompleted, 'true');
///   final value = await SecureStorageService.instance.read(StorageKeys.onboardingCompleted);
class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}

/// Keys used with [SecureStorageService].
abstract final class StorageKeys {
  static const String onboardingCompleted = 'onboarding_completed';
}
