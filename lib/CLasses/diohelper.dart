import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  //Initializing the BaseURl
  static init() {
    //declraing and setting the baseURL
    dio = Dio(BaseOptions(baseUrl: "https://newsapi.org/v2/"));
  }

  //Intializing the path and query from the URL
  static Future<Response?> get(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio?.get(path, queryParameters: query);
  }
}
