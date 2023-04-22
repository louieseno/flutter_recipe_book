import 'package:client/presenter/screens/recipe_form/recipe_form_controller.dart';
import 'package:client/presenter/widgets/conditional_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class RecipeFormScreen extends GetView<RecipeFormController> {
//   static const route = '/recipe_form';
//   const RecipeFormScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Recipe"),
//         ),
//         body: const Center(child: Text('loading')));
//   }
// }

class RecipeFormScreen extends GetView<RecipeFormController> {
  static const route = '/recipe';
  const RecipeFormScreen({super.key});

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
