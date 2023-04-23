import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_edamam_recipes.dart';
import 'package:client/domain/usecases/recipe/update_my_recipes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesController extends GetxController {
  dynamic myRecipes = Get.arguments;
  final TextEditingController searchTextController = TextEditingController();

  final List<String> removedRecipeIDs = [];

  final RxBool isFetching = false.obs;

  final RxList<String> selectedRecipeIDs = <String>[].obs;
  final RxList<EdamamRecipe> edamamMasterList = <EdamamRecipe>[].obs;

  final FetchEdamamRecipesUseCase _edamamRecipeUseCase =
      FetchEdamamRecipesUseCase();
  final UpdateMyRecipesUseCase _updateMyRecipesUseCase =
      UpdateMyRecipesUseCase();

  void saveMyList() async {
    final selectedRecipes = edamamMasterList
        .where((recipe) => selectedRecipeIDs.contains(recipe.id))
        .toList();
    await _updateMyRecipesUseCase.execute(selectedRecipes);

    // print("SELECTED: $selectedRecipeIDs");
    // print("REMOVED: $removedRecipeIDs");
    // print("MY RECIPES: $myRecipes");
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
    print(myRecipes);
    // selectedRecipeIDs.addAll(myRecipes);
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
