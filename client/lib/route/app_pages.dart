import 'package:client/presenter/screens/home/home_screen.dart';
import 'package:client/presenter/screens/online_recipes/online_recipes_screen.dart';
import 'package:client/route/app_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: OnlineRecipesScreen.route,
      page: () => const OnlineRecipesScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: HomeScreen.route,
      page: () => const HomeScreen(),
      binding: AppBinding(),
    ),
  ];
}
