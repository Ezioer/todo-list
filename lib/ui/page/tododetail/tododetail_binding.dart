import 'package:get/get.dart';
import 'package:todos/ui/page/tododetail/tododetail_controller.dart';

class TodoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoDetailController());
  }
}