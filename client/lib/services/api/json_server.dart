import 'dart:convert';

import 'package:client/domain/entities/recipe.dart';
import 'package:dio/dio.dart';

const baseURL = 'http://localhost:3000';

class JSONServerAPI {
  late Dio dio;

  static final JSONServerAPI _instance = JSONServerAPI._internal();
  factory JSONServerAPI() => _instance;
  JSONServerAPI._internal() {
    dio = Dio();
  }

  Future<List<Recipe>> getMyRecipes() async {
    try {
      final response = await dio.get("$baseURL/recipes");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.map((item) => Recipe.fromJson(item)).toList();
      }
    } catch (error, trace) {
      print("Error: $error. \n\Trace: $trace");
    }
    return [];
  }
}
