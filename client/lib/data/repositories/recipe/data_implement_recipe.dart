import 'dart:async';

import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/services/api/json_server.dart';
import 'package:client/services/api/edamam.dart';
import 'package:client/domain/repositories/recipe.dart';
import 'package:client/services/mixins/shared_preference_mixin.dart';
import 'package:client/services/mixins/sort_mixin.dart';

class DateImplementRecipe
    with SharedPreferenceMixin, SortMixin
    implements RecipeRepository {
  Future<List<EdamamRecipe>> _sortResponse(List<EdamamRecipe> response) async {
    final sortValue = await getSortingValue();
    if (sortValue != null) {
      sortList(sortValue, response);
    }
    return response;
  }

  @override
  Future<List<EdamamRecipe>> fetchEdamamRecipes({
    String? search,
  }) async {
    final List<EdamamRecipe> response =
        await EdamamAPI().getEdamamList(search: search);
    return _sortResponse(response);
  }

  @override
  Future<List<EdamamRecipe>> get fetchMyRecipes async {
    final List<EdamamRecipe> response = await JSONServerAPI().getMyRecipes();
    return _sortResponse(response);
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
