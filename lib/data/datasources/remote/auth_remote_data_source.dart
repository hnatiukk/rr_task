import 'package:injectable/injectable.dart';

import '../../models/login_request.dart';
import '../../models/login_response.dart';
import '../../models/logout_response.dart';
import '../../api/auth_api.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<LogoutResponse> logout(String token);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return await api.login(request);
  }

  @override
  Future<LogoutResponse> logout(String token) async {
    return await api.logout('Bearer $token');
  }
}
