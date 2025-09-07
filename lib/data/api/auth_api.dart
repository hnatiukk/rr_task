import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/logout_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("/logout")
  Future<LogoutResponse> logout(@Header("Authorization") String token);
}
