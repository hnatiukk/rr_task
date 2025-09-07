import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class TokenLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveUsername(String username);
  Future<String?> getToken();
  Future<String?> getUsername();
  Future<void> clearToken();
}

@LazySingleton(as: TokenLocalDataSource)
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final FlutterSecureStorage storage;
  static const _keyToken = 'auth_token';
  static const _keyUsername = 'username';

  TokenLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  @override
  Future<void> saveUsername(String username) async {
    await storage.write(key: _keyUsername, value: username);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }

  @override
  Future<String?> getUsername() async {
    return await storage.read(key: _keyUsername);
  }

  @override
  Future<void> clearToken() async {
    await storage.delete(key: _keyToken);
  }
}
