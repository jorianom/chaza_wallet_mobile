import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get instance => _dio;

  void setToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }
}
