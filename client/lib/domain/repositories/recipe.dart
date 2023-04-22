import 'package:client/domain/entities/recipe.dart';
import 'package:client/domain/entities/edamam_recipe.dart';

abstract class RecipeRepository {
  Future<List<EdamamRecipe>> get fetchEdamamRecipes;
  Future<List<Recipe>> get fetchMyRecipes;
}
