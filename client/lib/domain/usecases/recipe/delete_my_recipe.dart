import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/repositories/recipe.dart';
import 'package:client/data/repositories/recipe/data_implement_recipe.dart';

class DeleteMyRecipeUseCase {
  final RecipeRepository _recipeRepository;
  DeleteMyRecipeUseCase() : _recipeRepository = DateImplementRecipe();

  Future<void> execute(String id) async {
    return await _recipeRepository.deleteMyRecipe(id);
  }
}
