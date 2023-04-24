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
  final RxList<EdamamRecipe> selectedRecipes = <EdamamRecipe>[].obs;
  final FetchEdamamRecipesUseCase _fetchRecipeUseCase =
      FetchEdamamRecipesUseCase();

  final RxBool isSaving = false.obs;
  final UpdateMyRecipesUseCase _updateMyRecipesUseCase =
      UpdateMyRecipesUseCase();

  List<String> _fetchRecipeIds(List<EdamamRecipe> recipes) {
    return recipes.map((EdamamRecipe recipe) => recipe.id).toList();
  }

  Future<void> saveMyList() async {
    // Note: Since we are using JSON-SERVER as our mockup REST Web service there is a limitation on
    // what's in our control. Ideally we must put this condition on the backend to
    // avoid any performance issues.
    isSaving.value = true;
    final defaultIds = _fetchRecipeIds(myRecipes);
    final selectedIds = _fetchRecipeIds(selectedRecipes);
    final toRemoveIDs =
        defaultIds.where((String id) => !selectedIds.contains(id)).toList();
    final nonExistingRecipes = selectedRecipes
        .where((recipe) => !defaultIds.contains(recipe.id))
        .toList();

    await _updateMyRecipesUseCase.execute(nonExistingRecipes, toRemoveIDs);
    isSaving.value = false;
    Get.offAllNamed(HomeScreen.route);
  }

  bool isRecipeAdded(String id) {
    return selectedRecipes.firstWhereOrNull((selected) => selected.id == id) !=
        null;
  }

  void updateSelectedRecipe(EdamamRecipe recipe) {
    if (isRecipeAdded(recipe.id)) {
      selectedRecipes.removeWhere((selected) => selected.id == recipe.id);
    } else {
      selectedRecipes.add(recipe);
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

    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
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
    // selectedRecipes.value = myRecipes;
    selectedRecipes.addAll(myRecipes);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await _fetchMasterlist();
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    _searchDebounce?.cancel();
    super.onClose();
  }
}
