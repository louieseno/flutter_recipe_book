import 'package:get/get.dart';
import 'package:client/presenter/home/home_controller.dart';

class HomeBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut(() => HomeController());
    }
}