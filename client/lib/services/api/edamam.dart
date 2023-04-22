import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:dio/dio.dart';

const baseURL = 'https://edamam-recipe-search.p.rapidapi.com';
const start = 0;
const limit = 10;

class EdamamAPI {
  late Dio dio;

  static final EdamamAPI _instance = EdamamAPI._internal();
  factory EdamamAPI() => _instance;
  EdamamAPI._internal() {
    dio = Dio();
    dio.options.headers['X-RapidAPI-Key'] =
        'f3433cabcamsh76a57c9b445f4c0p1fcae0jsn08fb195ae9bc';
    dio.options.headers["X-RapidAPI-Host"] =
        'edamam-recipe-search.p.rapidapi.com';
  }

  Future<List<EdamamRecipe>> getEdamamList() async {
    try {
      final Response<dynamic> response = await dio.get("$baseURL/search",
          queryParameters: {"q": 'meatasds', "from": "$start", "to": "$limit"});
      List snapshot = [];

      if (response.statusCode == 200) {
        for (final item in response.data['hits']) {
          snapshot.add(item['recipe']);
        }
        return EdamamRecipe.recipesFromSnapshot(snapshot);
      }
    } catch (error, trace) {
      print("Error: $error. \n\Trace: $trace");
    }
    return [];
  }
}
