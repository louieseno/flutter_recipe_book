import 'package:client/presenter/screens/recipe_form/recipe_form_controller.dart';
import 'package:client/presenter/screens/home/home_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeFormController());
    Get.lazyPut(() => HomeController());
  }
}
