import 'package:client/domain/entities/edamam_recipe.dart';
import 'package:client/presenter/screens/home/home_controller.dart';
import 'package:client/presenter/screens/home/home_screen.dart';
import 'package:client/presenter/screens/online_recipes/online_recipes_controller.dart';
import 'package:client/presenter/widgets/cached_image.dart';
import 'package:client/services/extensions/string_extension.dart';
import 'package:client/services/mixins/recipe_dialog_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeList extends StatelessWidget with RecipeDialogMixin {
  final String screen;
  final List<EdamamRecipe> recipes;
  final bool? showBookmarkIcon;
  final bool? showDeleteIcon;
  const RecipeList(
      {required this.screen,
      required this.recipes,
      this.showBookmarkIcon = false,
      this.showDeleteIcon = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: RecipeStyles.listPadding,
              child: InkWell(
                onTap: () => showDetails(
                  context: context,
                  recipe: recipes[index],
                  addRecipe: screen == HomeScreen.route
                      ? null
                      : () => Get.find<OnlineRecipesController>()
                          .updateSelectedRecipe(recipes[index]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedImage(url: recipes[index].image),
                        Padding(
                          padding: RecipeStyles.labelPadding,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recipes[index].label,
                                  softWrap: true,
                                  style: RecipeStyles.labelStyle,
                                  maxLines: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 5.0),
                                  child: Text(
                                    recipes[index].dishType.toTitleCase(),
                                    style: RecipeStyles.dishTypeStyle,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: RecipeStyles.ingredientsStyle,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${recipes[index].ingredients.length}",
                                          style: RecipeStyles
                                              .ingedientsTotalStyle),
                                      const TextSpan(text: ' Ingredients')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (showBookmarkIcon == true)
                      Obx(() => IconButton(
                            icon: Icon(
                              Icons.bookmark_add,
                              size: 30,
                              color: Get.find<OnlineRecipesController>()
                                      .isRecipeAdded(recipes[index].id)
                                  ? Colors.pinkAccent
                                  : Colors.grey,
                            ),
                            onPressed: () => Get.find<OnlineRecipesController>()
                                .updateSelectedRecipe(recipes[index]),
                          )),
                    if (showDeleteIcon == true)
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => showDeletePrompt(
                          context: context,
                          recipe: recipes[index],
                          confirmedDelete: () => Get.find<HomeController>()
                              .deleteRecipe(recipes[index].id),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class RecipeStyles {
  static const listPadding =
      EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0);

  static const labelPadding = EdgeInsets.only(left: 10);

  static const labelStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  static const dishTypeStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static const ingredientsStyle =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400);

  static const ingedientsTotalStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.pinkAccent);
}
