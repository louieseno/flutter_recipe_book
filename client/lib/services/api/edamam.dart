import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:dio/dio.dart';
import 'package:client/env/env.dart';

const baseURL = 'https://edamam-recipe-search.p.rapidapi.com';
const start = 0;
const limit = 15;

class EdamamAPI {
  late Dio dio;

  static final EdamamAPI _instance = EdamamAPI._internal();
  factory EdamamAPI() => _instance;
  EdamamAPI._internal() {
    dio = Dio();
    dio.options.headers['X-RapidAPI-Key'] = Env.rapidAPIKey;
    dio.options.headers["X-RapidAPI-Host"] = Env.rapidAPIHost;
  }

  Future<List<EdamamRecipe>> getEdamamList({String? search}) async {
    try {
      final querySearch = search!.isNotEmpty ? search.toLowerCase() : "fish";

      final Response<dynamic> response = await dio.get("$baseURL/search",
          queryParameters: {
            "q": querySearch,
            "from": "$start",
            "to": "$limit"
          });
      List snapshot = [];

      if (response.statusCode == 200) {
        for (final item in response.data['hits']) {
          snapshot.add(item['recipe']);
        }
        if (snapshot.isNotEmpty) {
          return EdamamRecipe.recipesFromEdamam(snapshot);
        }
      }
    } catch (error, trace) {
      print("Error: $error. \n\nTrace: $trace");
    }
    return [];
  }
}
