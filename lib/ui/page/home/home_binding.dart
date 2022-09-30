import 'package:get/get.dart';
import 'package:todos/ui/page/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
  
}