import 'package:client/presenter/screens/online_recipes/online_recipes_screen.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:client/presenter/widgets/custom_loader.dart';
import 'package:client/presenter/widgets/recipe_list.dart';
import 'package:client/services/mixins/recipe_dialog_mixin.dart';
import 'package:client/services/mixins/sort_mixin.dart';
import 'package:flutter/material.dart';
import 'package:client/presenter/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> with RecipeDialogMixin {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes"),
        actions: [
          IconButton(
            onPressed: () => showSorting(
                context: context,
                onSort: (String value) {
                  controller.sortRecipeList(value);
                  Navigator.of(context).pop();
                }),
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: Center(
          child: Padding(
        padding: HomeScreenStyle.containerPadding,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15.0),
              child: TextField(
                controller: controller.searchTextController,
                onChanged: (String value) => controller.searchMyRecipe(value),
                decoration: HomeScreenStyle.searchBoxstyle,
              ),
            ),
            Obx(
              () => ConditionalWidget(
                condition: controller.isFetching.value,
                passedWidget: const CustomLoader(
                  message: 'Fetching My Recipes',
                ),
                failedWidget: ConditionalWidget(
                  condition: controller.myRecipes.isEmpty,
                  passedWidget: Container(
                    margin: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.auto_stories_outlined,
                          color: Colors.purple,
                          size: 100,
                        ),
                        Text('No Recipe Data',
                            style: HomeScreenStyle.noDataTextStyle)
                      ],
                    ),
                  ),
                  failedWidget: RecipeList(
                    screen: HomeScreen.route,
                    recipes: controller.myRecipes,
                    showDeleteIcon: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () => Get.toNamed(
              OnlineRecipesScreen.route,
              arguments: controller.myRecipes,
            ),
            tooltip:
                controller.myRecipes.isEmpty ? 'Add Recipes' : 'Modify Recipes',
            child: ConditionalWidget(
              condition: controller.myRecipes.isEmpty,
              passedWidget: const Icon(Icons.add),
              failedWidget: const Icon(Icons.edit),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeScreenStyle {
  static const containerPadding = EdgeInsets.all(16.0);

  static const noDataTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  static final searchBoxstyle = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[400]),
      hintText: "Search My Recipe",
      fillColor: Colors.white70);
}
