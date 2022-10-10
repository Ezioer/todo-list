import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/ui/page/home/home_controller.dart';

import '../../../base/get/controller/base_page_controller.dart';
import 'package:get/get.dart';

import '../../../db/model/todolist_entity.dart';
import '../../../widget/pull_smart_refresher.dart';

class AddListController extends BaseGetPageController {
  int isDeleteStopTime = 0;
  String stopValue = "设置截至日期";
  int isDeleteNoti = 0;
  String notiValue = "提醒我";
  DateTime dateTime = new DateTime(2022, 09, 22);
  TodoListEntity typeEntity = TodoListEntity(id: 0, title: "", des: "", createTime: "", bgColor: "0", sortType: 1, type: 2, count: 0);
  List<TodoEntity> todoList = [];
  String defaultBg = "0";
  int stopTime = 0;
  String notiTime = "0";

  ///输入框文本控制器
  TextEditingController textController = TextEditingController(text: "");
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController desController = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
    defaultBg = typeEntity.bgColor;
    getTodoList(typeEntity.id!);
  }

  void changeBg(int index) {
    defaultBg = "${index}";
    MyDatabase.getInstance()?.updateToListBg(typeEntity, defaultBg);
    Get.find<HomeController>().getSystemFromDatabase(typeEntity.type!);
    update();
  }

  void sortList(int type) {
    //1 默认时间升序 2 时间降序 3重要性优先
    if (type ==1) {
      todoList.sort((a,b) =>int.parse(a.createTime!).compareTo(int.parse(b.createTime!)));
    } else if(type == 2) {
      todoList.sort((a,b) =>int.parse(a.createTime!).compareTo(int.parse(b.createTime!)));
      todoList = todoList.reversed.toList();
    } else {
      var results = groupBy(todoList, (TodoEntity item) => item.isMark);
      if (results[1] != null) {
        todoList = results[1]!;
        todoList.addAll(results[0]!);
      }
    }
    update();
  }

  void getTodoList(int type) {
    request.getTodoList(type, success: (data, over) {
      if (refresh != Refresh.down) {
        todoList.clear();
      }
      todoList.addAll(data);
      showSuccess(todoList);
      update();
    }, fail: (code, msg) {
      showError();
    });
  }

  void changeIsDelete(int value, String text) {
    if(value == 0) {
      stopTime = 0;
    }
    isDeleteStopTime = value;
    stopValue = text;
    update();
  }

  void changeIsNoti(int value, String text) {
    if(value == 0) {
      notiTime = "0";
    }
    isDeleteNoti = value;
    notiValue = text;
    update();
  }

  void updateTaskStatus(TodoEntity entity) {
    MyDatabase.getInstance()!.updateTodo(entity);
  }

  void addDiyList() async {
    String times = DateTime.now().microsecond.toString();
    int id = await MyDatabase.getInstance()!.insertDiyList(
        todolist(id: 0, title: titleController.text, des: desController.text, createTime: times, bgColor: typeEntity.bgColor, sortType: typeEntity.sortType!, type: 2, count: 0));
    typeEntity.id = id;
    typeEntity.title = titleController.text;
    typeEntity.des = desController.text;
    typeEntity.createTime = times;
    updateHome();
    update();
  }

  void updateDiyList() async {
    await MyDatabase.getInstance()!.updateDiyList(todolist(
        id: typeEntity.id!,
        title: titleController.text,
        des: desController.text,
        createTime:typeEntity.createTime!,
        bgColor: typeEntity.bgColor,
        sortType: typeEntity.sortType!,
        type: 2,
        count: typeEntity.count));
    updateHome();
    typeEntity.title = titleController.text;
    typeEntity.des = desController.text;
    update();
  }

  void updateHome() async {
    Get.find<HomeController>().getSystemFromDatabase(2);
  }
}
