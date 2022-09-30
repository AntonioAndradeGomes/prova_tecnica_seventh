import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {};
    final dio = Dio();
    try {
      final response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );
      return response.data;
    } on DioError catch (err) {
      if (err.response!.statusCode! >= 500) {
        return {
          "message": "server error",
          "code": err.response!.statusCode!,
        };
      }
      final map = err.response?.data ?? {};
      map['code'] = err.response?.statusCode ?? 500;
      return map;
    } catch (error) {
      developer.log(
        error.toString(),
        name: 'HttpManager',
      );
      return {
        "message": "app error",
        "code": 500,
      };
    }
  }
}
