import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/local/token_local_data_source.dart';
import '../models/login_request.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final response = await remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );

    await localDataSource.saveToken(response.token);
    await localDataSource.saveUsername(response.username);

    return User(username: response.username, token: response.token);
  }

  @override
  Future<void> logout() async {
    String token = await getToken() ?? '';
    await remoteDataSource.logout(token);
    await localDataSource.clearToken();
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<User> getUser() async {
    String token = await localDataSource.getToken() ?? '';
    String username = await localDataSource.getUsername() ?? 'Unknown';

    return User(username: username, token: token);
  }
}
