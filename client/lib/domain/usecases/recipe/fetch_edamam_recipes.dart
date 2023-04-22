import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/repositories/recipe.dart';
import 'package:client/data/repositories/recipe/data_implement_recipe.dart';

class FetchEdamamRecipesUseCase {
  final RecipeRepository _recipeRepository;
  FetchEdamamRecipesUseCase() : _recipeRepository = DateImplementRecipe();

  Future<List<EdamamRecipe>> execute() async {
    return await _recipeRepository.fetchEdamamRecipes;
  }
}
