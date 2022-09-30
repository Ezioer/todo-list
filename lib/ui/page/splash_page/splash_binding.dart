import 'package:get/get.dart';
import 'package:todos/ui/page/splash_page/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
  
}