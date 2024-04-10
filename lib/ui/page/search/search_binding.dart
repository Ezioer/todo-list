import 'package:get/get.dart';
import 'package:todos/ui/page/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchReController());
  }
  
}