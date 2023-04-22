import 'package:client/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> get getRecipes;
}
