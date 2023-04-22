import 'package:client/presenter/screens/home/home_screen.dart';
import 'package:client/presenter/screens/recipe_form/recipe_form_screen.dart';
import 'package:client/route/app_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: RecipeFormScreen.route,
      page: () => const RecipeFormScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: HomeScreen.route,
      page: () => const HomeScreen(),
      binding: AppBinding(),
    ),
  ];
}
