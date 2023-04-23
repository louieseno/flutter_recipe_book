import 'dart:async';

import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/domain/usecases/recipe/delete_my_recipe.dart';
import 'package:client/domain/usecases/recipe/fetch_my_recipes.dart';
import 'package:client/services/mixins/shared_preference_mixin.dart';
import 'package:client/services/mixins/sort_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with SharedPreferenceMixin, SortMixin {
  Timer? _searchDebounce;
  final TextEditingController searchTextController = TextEditingController();

  final RxBool isFetching = false.obs;
  final RxList<EdamamRecipe> myRecipes = <EdamamRecipe>[].obs;
  final FetchMyRecipesUseCase _myRecipeUseCase = FetchMyRecipesUseCase();

  final DeleteMyRecipeUseCase _deleteRecipeUseCase = DeleteMyRecipeUseCase();

  Future<void> deleteRecipe(String id) async {
    await _deleteRecipeUseCase.execute(id);
    myRecipes.removeWhere((EdamamRecipe recipe) => recipe.id == id);
  }

  Future<void> sortRecipeList(String value) async {
    isFetching.value = true;
    await setSortingValue(value);
    sortList(value, myRecipes);
    myRecipes.refresh();
    isFetching.value = false;
  }

  void searchMyRecipe(String search) {
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce?.cancel();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      await _fetchMyRecipes(searchValue: search);
    });
  }

  Future<void> _fetchMyRecipes({String? searchValue = ''}) async {
    isFetching.value = true;
    final result = await _myRecipeUseCase.execute(search: searchValue);
    myRecipes.value = result;
    isFetching.value = false;
  }

  @override
  Future<void> onReady() async {
    await _fetchMyRecipes();
    super.onReady();
  }
}
