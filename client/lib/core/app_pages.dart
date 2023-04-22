import 'package:client/presenter/home/home_binding.dart';
import 'package:client/presenter/home/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: HomeScreen.route,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}