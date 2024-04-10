import 'package:flutter/material.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';

import '../../../base/get/controller/base_page_controller.dart';
import 'package:get/get.dart';

import '../../../db/model/todolist_entity.dart';
import '../../../widget/pull_smart_refresher.dart';
class SearchReController extends BaseGetPageController {
  List<TodoEntity> list = [];

  ///输入框文本控制器
  TextEditingController textController = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
  }

  void searchResult(String key) async{
      request.getTodoListBySearch(key, success: (data, over) {
        if (refresh != Refresh.down) {
            list.clear();
        }
        list.addAll(data);
        showSuccess(list);
        update();
      }, fail: (code, msg) {
        showError();
      });
    }
}
