import 'dart:async';
import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_edamam_recipes.dart';
import 'package:client/domain/usecases/recipe/update_my_recipes.dart';
import 'package:client/presenter/screens/home/home_screen.dart';
import 'package:client/services/mixins/shared_preference_mixin.dart';
import 'package:client/services/mixins/sort_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesController extends GetxController
    with SharedPreferenceMixin, SortMixin {
  List<EdamamRecipe> myRecipes = Get.arguments;

  Timer? _searchDebounce;
  final TextEditingController searchTextController = TextEditingController();

  final RxBool isFetching = false.obs;
  final RxList<EdamamRecipe> edamamMasterList = <EdamamRecipe>[].obs;
  final RxList<String> selectedRecipeIDs = <String>[].obs;
  final FetchEdamamRecipesUseCase _fetchRecipeUseCase =
      FetchEdamamRecipesUseCase();

  final RxBool isSaving = false.obs;
  final UpdateMyRecipesUseCase _updateMyRecipesUseCase =
      UpdateMyRecipesUseCase();

  Future<void> saveMyList() async {
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

  Future<void> sortRecipeList(String value) async {
    isFetching.value = true;
    await setSortingValue(value);
    sortList(value, edamamMasterList);
    edamamMasterList.refresh();
    isFetching.value = false;
  }

  void searchFoodRecipe(String search) {
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce?.cancel();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 800), () async {
      await _fetchMasterlist(searchValue: search);
    });
  }

  Future<void> _fetchMasterlist({String? searchValue = ''}) async {
    isFetching.value = true;
    final result = await _fetchRecipeUseCase.execute(search: searchValue);
    edamamMasterList.value = result;
    isFetching.value = false;
  }

  @override
  Future<void> onInit() async {
    final defaultIds =
        myRecipes.map((EdamamRecipe recipe) => recipe.id).toList();
    selectedRecipeIDs.value = defaultIds;
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    print('READY recipe');
    await _fetchMasterlist();
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    _searchDebounce?.cancel();
    super.onClose();
  }
}
