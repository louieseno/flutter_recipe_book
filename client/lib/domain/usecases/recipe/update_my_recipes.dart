import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/repositories/recipe.dart';
import 'package:client/data/repositories/recipe/data_implement_recipe.dart';

class UpdateMyRecipesUseCase {
  final RecipeRepository _recipeRepository;
  UpdateMyRecipesUseCase() : _recipeRepository = DateImplementRecipe();

  Future<void> execute(
      List<EdamamRecipe> recipes, List<String> toRemoveIds) async {
    return await _recipeRepository.updateMyRecipes(recipes, toRemoveIds);
  }
}
