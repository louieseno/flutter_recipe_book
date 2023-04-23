import 'dart:async';

import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/services/api/json_server.dart';
import 'package:client/services/api/edamam.dart';
import 'package:client/domain/repositories/recipe.dart';

class DateImplementRecipe implements RecipeRepository {
  @override
  Future<List<EdamamRecipe>> fetchEdamamRecipes({
    String? search,
  }) async {
    final List<EdamamRecipe> response =
        await EdamamAPI().getEdamamList(search: search);
    return response;
  }

  @override
  Future<List<EdamamRecipe>> get fetchMyRecipes async {
    final List<EdamamRecipe> response = await JSONServerAPI().getMyRecipes();
    return response;
  }

  @override
  Future<void> updateMyRecipes(
      List<EdamamRecipe> recipes, List<String> toRemoveIds) async {
    await JSONServerAPI().updateMyRecipes(recipes, toRemoveIds);
  }

  @override
  Future<void> deleteMyRecipe(String id) async {
    await JSONServerAPI().deleteMyRecipe(id);
  }
}
