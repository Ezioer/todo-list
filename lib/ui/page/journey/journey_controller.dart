import 'package:todos/util/save/sp_util.dart';
import '../../../base/get/controller/base_page_controller.dart';
import '../../../db/db_manager.dart';
import '../../../db/model/todolist_entity.dart';
import '../../../widget/pull_smart_refresher.dart';

class JourneyController extends BaseGetPageController {
  List<TodoListEntity> list = [];

  @override
  void onInit() {
    super.onInit();
  }
}
