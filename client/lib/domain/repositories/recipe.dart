import 'package:client/domain/entities/edamam_recipe.dart';

abstract class RecipeRepository {
  Future<List<EdamamRecipe>> fetchEdamamRecipes({String? search});
  Future<List<EdamamRecipe>> fetchMyRecipes({String? search});
  Future<void> updateMyRecipes(
      List<EdamamRecipe> recipes, List<String> toRemoveIds);
  Future<void> deleteMyRecipe(String id);
}
