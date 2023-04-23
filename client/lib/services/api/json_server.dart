import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:dio/dio.dart';

const baseURL = 'http://localhost:3000';

class JSONServerAPI {
  late Dio dio;

  static final JSONServerAPI _instance = JSONServerAPI._internal();
  factory JSONServerAPI() => _instance;
  JSONServerAPI._internal() {
    dio = Dio();
  }

  Future<List<EdamamRecipe>> getMyRecipes() async {
    try {
      final response = await dio.get("$baseURL/recipes");
      if (response.statusCode == 200) {
        final snapshot = response.data as List<dynamic>;
        return EdamamRecipe.recipesFromJsonServer(snapshot);
      }
    } catch (error, trace) {
      print("Error: $error. \n\nTrace: $trace");
    }
    return [];
  }

  Future<void> updateMyRecipes(List<EdamamRecipe> recipes) async {
    try {
      final toInsert = EdamamRecipe.objectFromRecipes(recipes);
      var futures = await Future.wait(toInsert
          .map((object) => dio.post("$baseURL/recipes", data: object))
          .toList());
      print("update");
    } catch (error, trace) {
      print("Error: $error. \n\nTrace: $trace");
    }
    return;
  }
}
