import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/db/model/todolist_entity.dart';
import 'package:todos/http/http_request.dart';

typedef SuccessOver<T> = Function(T data, bool over);

class RequestRepository {
  getList(
    int type, {
    SuccessOver<List<TodoListEntity>>? success,
    Fail? fail,
  }) async {
    if (success != null) {
      if (type == 1) {
        List<todolist> list = await MyDatabase?.getInstance()!.getSystemList();
        List<TodoListEntity> dataList = [];
        for (todolist item in list) {
          dataList.add(TodoListEntity(id: item.id, title: item.title, des: item.des, createTime: item.createTime, bgColor: item.bgColor, sortType: item.sortType, type: item.type,count: item.count));
        }
        success(dataList, true);
      } else {
        List<todolist> list = await MyDatabase?.getInstance()!.getDiyList();
        List<TodoListEntity> dataList = [];
        for (todolist item in list) {
          dataList.add(TodoListEntity(id: item.id, title: item.title, des: item.des, createTime: item.createTime, bgColor: item.bgColor, sortType: item.sortType, type: item.type,count: item.count));
        }
        success(dataList, true);
      }
    }
  }

  getTodoList(
    int type, {
    SuccessOver<List<TodoEntity>>? success,
    Fail? fail,
  }) async {
    if (success != null) {
      List<todo> list = [];
      if (type == 5) {
        list = await MyDatabase?.getInstance()!.findCompleted();
      } else if (type == 4) {
        list = await MyDatabase?.getInstance()!.findAllWork();
      } else if (type == 2) {
        list = await MyDatabase?.getInstance()!.findAllImportant();
      } else if(type == 1){
        list = await MyDatabase?.getInstance()!.findToDay();
      } else {
        list = await MyDatabase?.getInstance()!.findTodo(type);
      }
      List<TodoEntity> todoEntity = [];
      for (todo d in list) {
        todoEntity.add(TodoEntity(
            id: d.id, title: d.title, des: d.des, createTime: d.createTime, stopTime: d.stopTime, notiTime:d.notiTime,type: d.type, isMark: d.isMark, isMyDay: d.isMyDay, isFinish: d.isFinish));
      }
      success(todoEntity, true);
    }
  }

  getTodoListBySearch(
      String key, {
        SuccessOver<List<TodoEntity>>? success,
        Fail? fail,
      }) async {
    if (success != null) {
      List<todo> list = [];
      list = await MyDatabase?.getInstance()!.findTodoByKey(key);
      List<TodoEntity> todoEntity = [];
      for (todo d in list) {
        todoEntity.add(TodoEntity(
            id: d.id, title: d.title, des: d.des, createTime: d.createTime, createTimeYMD:d.createTimeYMD,stopTime: d.stopTime, notiTime:d.notiTime,type: d.type, isMark: d.isMark, isMyDay: d.isMyDay, isFinish: d.isFinish));
      }
      success(todoEntity, true);
    }
  }
}
