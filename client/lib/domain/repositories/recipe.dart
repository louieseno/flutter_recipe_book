import 'package:client/domain/entities/edamam_recipe.dart';

abstract class RecipeRepository {
  Future<List<EdamamRecipe>> get fetchEdamamRecipes;
  Future<List<EdamamRecipe>> get fetchMyRecipes;
  Future<void> updateMyRecipes(List<EdamamRecipe> recipes);
}
