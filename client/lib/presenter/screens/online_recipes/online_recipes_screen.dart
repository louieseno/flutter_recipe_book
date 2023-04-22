import 'package:client/presenter/screens/online_recipes/online_recipes_controller.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineRecipesScreen extends GetView<OnlineRecipesController> {
  static const route = '/recipe';
  const OnlineRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe"),
      ),
      body: Center(
          child: Obx(
        () => ConditionalWidget(
          condition: controller.isFetching.value,
          passedWidget: const CircularProgressIndicator(),
          failedWidget: const Text('done loading'),
        ),
      )),
    );
  }
}
