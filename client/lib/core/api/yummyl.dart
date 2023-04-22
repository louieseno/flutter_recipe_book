import 'package:dio/dio.dart';
const baseURL = 'https://yummly2.p.rapidapi.com';


class YummlyAPI {
  late Dio dio;

  static final YummlyAPI _instance = YummlyAPI._internal();
  factory YummlyAPI() => _instance;
  YummlyAPI._internal() {
    dio = Dio();
    dio.options.headers['X-RapidAPI-Key'] = 'f3433cabcamsh76a57c9b445f4c0p1fcae0jsn08fb195ae9bc';
    dio.options.headers["X-RapidAPI-Host"] = 'yummly2.p.rapidapi.com';
  }

  Future<Response<dynamic>> getYummlyList() async {
    final Response<dynamic> response = await dio.get("$baseURL/feeds/list", queryParameters: {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular"
    });
    return response;
  } 


}