import 'package:client/domain/entities/recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_my_recipes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isFetching = false.obs;
  final RxList<Recipe> myRecipes = <Recipe>[].obs;
  final FetchMyRecipesUseCase _myRecipeUseCase = FetchMyRecipesUseCase();

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
