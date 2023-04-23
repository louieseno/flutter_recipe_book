import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_edamam_recipes.dart';
import 'package:client/domain/usecases/recipe/update_my_recipes.dart';
import 'package:client/presenter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesController extends GetxController {
  List<EdamamRecipe> myRecipes = Get.arguments;
  final TextEditingController searchTextController = TextEditingController();

  final RxBool isFetching = false.obs;
  final RxList<EdamamRecipe> edamamMasterList = <EdamamRecipe>[].obs;
  final RxList<String> selectedRecipeIDs = <String>[].obs;
  final FetchEdamamRecipesUseCase _edamamRecipeUseCase =
      FetchEdamamRecipesUseCase();

  final RxBool isSaving = false.obs;
  final UpdateMyRecipesUseCase _updateMyRecipesUseCase =
      UpdateMyRecipesUseCase();

  void saveMyList() async {
    isSaving.value = true;
    final defaultIds =
        myRecipes.map((EdamamRecipe recipe) => recipe.id).toList();

    final toRemoveIDs = defaultIds
        .where((String id) => !selectedRecipeIDs.contains(id))
        .toList();

    final nonExistingRecipes = edamamMasterList
        .where((recipe) =>
            selectedRecipeIDs.contains(recipe.id) &&
            !defaultIds.contains(recipe.id))
        .toList();

    await _updateMyRecipesUseCase.execute(nonExistingRecipes, toRemoveIDs);
    isSaving.value = false;
    Get.offAllNamed(HomeScreen.route);
  }

  void updateSelectedRecipe(String id) {
    if (selectedRecipeIDs.contains(id)) {
      selectedRecipeIDs.remove(id);
    } else {
      selectedRecipeIDs.add(id);
    }
  }

  @override
  Future<void> onInit() async {
    final defaultIds =
        myRecipes.map((EdamamRecipe recipe) => recipe.id).toList();
    selectedRecipeIDs.addAll(defaultIds);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    print('READY recipe');
    searchTextController.text = 'fish';
    await _fetchMasterlist();
    super.onReady();
  }

  Future<void> _fetchMasterlist() async {
    isFetching.value = true;
    final result = await _edamamRecipeUseCase.execute();
    edamamMasterList.addAll(result);
    isFetching.value = false;
  }
}
