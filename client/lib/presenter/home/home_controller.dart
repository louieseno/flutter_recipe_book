import 'package:get/get.dart';

class HomeController extends GetxController {
  var count = 0.obs;
  void increment() {
    count++;
  }

  @override
  Future<void> onInit() async {
    
    super.onInit();
  }

   @override
  Future<void> onReady() async {
 
    super.onReady();
  }

  @override
  void onClose() {}
}