import 'dart:async';

import 'package:client/core/api/yummyl.dart';
import 'package:client/domain/entities/recipe.dart';
import 'package:client/domain/repositories/recipe.dart';

class DateImplementRecipe implements RecipeRepository{

  @override
  Future<List<Recipe>> get getRecipes async {
    final response = await YummlyAPI().getYummlyList();
    return [];
  }

}