import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/repositories/recipe.dart';
import 'package:client/data/repositories/recipe/data_implement_recipe.dart';

class FetchMyRecipesUseCase {
  final RecipeRepository _recipeRepository;
  FetchMyRecipesUseCase() : _recipeRepository = DateImplementRecipe();

  Future<List<EdamamRecipe>> execute({String? search}) async {
    return await _recipeRepository.fetchMyRecipes(search: search);
  }
}
