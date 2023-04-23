import 'package:client/presenter/screens/online_recipes/online_recipes_controller.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:client/presenter/widgets/custom_loader.dart';
import 'package:client/presenter/widgets/footer_button.dart';
import 'package:client/presenter/widgets/recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesScreen extends GetView<OnlineRecipesController> {
  static const route = '/recipe';
  const OnlineRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Recipes"),
      ),
      body: Center(
        child: Padding(
          padding: RecipeStyle.containerPadding,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                child: TextField(
                  controller: controller.searchTextController,
                  onChanged: (String value) =>
                      controller.searchFoodRecipe(value),
                  decoration: RecipeStyle.searchBoxstyle,
                ),
              ),
              Obx(
                () => ConditionalWidget(
                  condition: controller.isFetching.value,
                  passedWidget: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomLoader(
                      message: 'Fetching Online Recipes',
                    ),
                  ),
                  failedWidget: RecipeList(
                    screen: OnlineRecipesScreen.route,
                    recipes: controller.edamamMasterList,
                    showBookmarkIcon: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => !controller.isFetching.value
          ? Padding(
              padding: RecipeStyle.saveButtonStyle,
              child: FooterButton(
                onTap: () => controller.saveMyList(),
              ),
            )
          : const SizedBox(width: 0.0, height: 0.0)),
    );
  }
}

class RecipeStyle {
  static final searchBoxstyle = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[400]),
      hintText: "Search Recipe",
      fillColor: Colors.white70);

  static const containerPadding = EdgeInsets.all(16.0);

  static const saveButtonStyle = EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 35.0);
}
