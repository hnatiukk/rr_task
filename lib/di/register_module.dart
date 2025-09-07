import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rr_task/core/dio/interceptors/mock_interceptor.dart';
import '../data/api/auth_api.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dio {
    final dio = Dio(BaseOptions());

    dio.interceptors.add(MockInterceptor());

    return dio;
  }

  @lazySingleton
  AuthApi authApi(Dio dio) =>
      AuthApi(dio, baseUrl: dotenv.env['BASE_URL'] ?? '');
}
