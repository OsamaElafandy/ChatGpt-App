import 'dart:developer';
import 'package:dio/dio.dart';

class Services {
  static Future<dynamic> post(String url, dynamic data) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      return await Dio().post(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioError catch (e) {
      return e.message!;
    }
  }
}
