import 'package:get/get.dart';
import 'package:todos/ui/page/listdetail/listdetail_controller.dart';

class ListDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListDetailController());
  }
  
}