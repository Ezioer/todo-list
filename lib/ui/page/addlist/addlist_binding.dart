import 'package:get/get.dart';
import 'package:todos/ui/page/addlist/addlist_controller.dart';

class AddListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddListController());
  }
  
}