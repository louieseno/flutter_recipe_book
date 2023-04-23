import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/delete_my_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_my_recipes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool isFetching = false.obs;
  final RxList<EdamamRecipe> myRecipes = <EdamamRecipe>[].obs;
  final FetchMyRecipesUseCase _myRecipeUseCase = FetchMyRecipesUseCase();

  final DeleteMyRecipeUseCase _deleteRecipeUseCase = DeleteMyRecipeUseCase();

  Future<void> deleteRecipe(String id) async {
    await _deleteRecipeUseCase.execute(id);
    myRecipes.removeWhere((EdamamRecipe recipe) => recipe.id == id);
  }

  @override
  Future<void> onReady() async {
    print("HOME");
    await _fetchMyRecipes();
    super.onReady();
  }

  Future<void> _fetchMyRecipes() async {
    isFetching.value = true;
    final result = await _myRecipeUseCase.execute();
    myRecipes.addAll(result);
    isFetching.value = false;
  }
}
