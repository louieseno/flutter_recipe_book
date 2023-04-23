import 'package:client/presenter/screens/online_recipes/online_recipes_screen.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:client/presenter/widgets/recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:client/presenter/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes"),
      ),
      body: Center(
          child: Obx(
        () => ConditionalWidget(
          condition: controller.isFetching.value,
          passedWidget: const CircularProgressIndicator(),
          failedWidget: ConditionalWidget(
            condition: controller.myRecipes.isEmpty,
            passedWidget: const Text('Empty'),
            failedWidget: Padding(
              padding: RecipeStyle.containerPadding,
              child: Column(
                children: [
                  RecipeList(
                    screen: HomeScreen.route,
                    recipes: controller.myRecipes,
                    showDeleteIcon: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
