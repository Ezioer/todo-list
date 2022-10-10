import 'package:flutter/material.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/ui/page/home/home_controller.dart';

import '../../../base/get/controller/base_page_controller.dart';
import 'package:get/get.dart';


class TodoDetailController extends BaseGetPageController {
  int isDeleteStopTime = 0;
  String stopValue = "设置截至日期";
  int isDeleteNoti = 0;
  String notiValue = "提醒我";
  DateTime dateTime = new DateTime(2022, 09, 22);
  TodoEntity data = Get.arguments;
  bool isEdit = true;
  ///输入框文本控制器
  TextEditingController textController = TextEditingController(text: "");
  TextEditingController? titleController;
  TextEditingController? desController;
  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: "${data.title}");
    desController=  TextEditingController(text: "${data.des}");
  }

  void changeIsDelete(int value, String text) {
    if(value == 0) {
      data.stopTime = 0;
    }
    isDeleteStopTime = value;
    stopValue = text;
    update();
  }

  void changeIsNoti(int value, String text) {
    if(value == 0) {
      data.notiTime = "0";
    }
    isDeleteNoti = value;
    notiValue = text;
    update();
  }

  void updateTaskStatus(TodoEntity entity) {
    MyDatabase.getInstance()!.updateTodo(entity);
  }

  void updateHome() async {
    Get.find<HomeController>().getSystemFromDatabase(2);
  }
}
