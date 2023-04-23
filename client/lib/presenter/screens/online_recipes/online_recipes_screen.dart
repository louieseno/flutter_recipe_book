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
        child: Obx(
          () => ConditionalWidget(
            condition: controller.isFetching.value,
            passedWidget: const CustomLoader(
              message: 'Fetching Online Recipes',
            ),
            failedWidget: Padding(
              padding: RecipeStyle.containerPadding,
              child: Column(
                children: [
                  TextField(
                    controller: controller.searchTextController,
                    decoration: RecipeStyle.searchBoxstyle,
                  ),
                  RecipeList(
                    screen: OnlineRecipesScreen.route,
                    recipes: controller.edamamMasterList,
                    showBookmarkIcon: true,
                  ),
                  Padding(
                    padding: RecipeStyle.saveButtonStyle,
                    child: FooterButton(
                      onTap: () => controller.saveMyList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

  static const saveButtonStyle =
      EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0);
}
