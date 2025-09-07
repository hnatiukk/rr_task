import 'package:dio/dio.dart';

class MockInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.endsWith("/login")) {
      final data = options.data;
      final email = data['email'] as String?;
      final password = data['password'] as String?;

      await Future.delayed(const Duration(seconds: 1));

      if (email == "jd@test.com" && password == "123456") {
        handler.resolve(
          Response(
            requestOptions: options,
            data: {
              "token": "token_${DateTime.now().millisecondsSinceEpoch}",
              "username": "John Doe",
            },
            statusCode: 200,
          ),
        );
      } else {
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 401,
              data: {"message": "Invalid credentials"},
            ),
          ),
        );
      }
      return;
    }

    if (options.path.endsWith("/logout")) {
      await Future.delayed(const Duration(seconds: 1));
      handler.resolve(
        Response(
          requestOptions: options,
          data: {"success": true},
          statusCode: 200,
        ),
      );
      return;
    }

    super.onRequest(options, handler);
  }
}
