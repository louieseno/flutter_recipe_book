import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_edamam_recipes.dart';
import 'package:get/get.dart';

class OnlineRecipesController extends GetxController {
  RxBool isFetching = false.obs;
  final RxList<EdamamRecipe> edamamMasterList = <EdamamRecipe>[].obs;
  final FetchEdamamRecipesUseCase _edamamRecipeUseCase =
      FetchEdamamRecipesUseCase();

  @override
  Future<void> onReady() async {
    print('READY recipe');
    await _fetchMasterlist();
    super.onReady();
  }

  Future<void> _fetchMasterlist() async {
    isFetching.value = true;
    final result = await _edamamRecipeUseCase.execute();
    print(result);
    edamamMasterList.addAll(result);
    isFetching.value = false;
  }
}
