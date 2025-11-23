import 'package:dio/dio.dart';

class DioClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/products",
      // connectTimeout: Duration(seconds: 10),
    ),
  );
}
