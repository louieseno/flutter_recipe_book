import 'package:client/presenter/screens/online_recipes/online_recipes_screen.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
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
            failedWidget: const Text('Non-Empty'),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          OnlineRecipesScreen.route,
          arguments: controller.myRecipes,
        ),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
