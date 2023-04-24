import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/services/constants/enums.dart';

mixin SortMixin {
  void sortList(String sort, List<EdamamRecipe> recipes) {
    recipes.sort((a, b) {
      if (sort == SortByValue.ascending.name) {
        return a.label.toLowerCase().compareTo(b.label.toLowerCase());
      } else {
        return b.label.toLowerCase().compareTo(a.label.toLowerCase());
      }
    });
  }
}
