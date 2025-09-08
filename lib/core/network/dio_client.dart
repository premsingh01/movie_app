import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.addAll([
      // Log all requests and responses
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 🔑 Add headers globally
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          final token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZGI4MTI5MDljZWM2OThkMTljMzhkZTUwYTM0ODBiNSIsIm5iZiI6MTc1NzMzNTAwNi4xNDgsInN1YiI6IjY4YmVjZGRlYmY1MjdjOTNhNTRlNjQ1MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.--1KDCCIGrEKnf6pyPeXfQ3jLx_FYZvznqMxmI-CoI4";
          options.headers['Authorization'] = 'Bearer $token';

          // Example: add token if needed
          // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle successful responses
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Centralized error handling
          print("Dio Error: ${e.message}");
          return handler.next(e);
        },
      ),
    ]);

    return dio;
  }
}
