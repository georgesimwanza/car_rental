import 'package:dio/dio.dart';
import 'package:car_rental/features/auth/exceptions/auth_exception.dart';

class ApiClient {
  static const String _baseUrl = 'https://your-api.com/api/v1';

  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(_AuthInterceptor());
  }

  Dio get dio => _dio;

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AuthException authException;

    switch (err.response?.statusCode) {
      case 401:
        authException = const SessionExpiredException();
      case 422:
        authException = const InvalidCredentialsException();
      case 409:
        authException = const EmailAlreadyInUseException();
      case null:
        authException = const NetworkException();
      default:
        authException = ServerException(statusCode: err.response?.statusCode);
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: authException,
        message: authException.message,
      ),
    );
  }
}
