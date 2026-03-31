import 'package:dio/dio.dart';

class DioClient {
  static Dio getDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "http://172.30.1.49:3000/",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
// 172.30.1.49