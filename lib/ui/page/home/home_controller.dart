import 'dart:ui';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos/util/save/sp_util.dart';

import '../../../base/get/controller/base_page_controller.dart';
import '../../../db/db_manager.dart';
import '../../../db/model/todolist_entity.dart';
import '../../../widget/pull_smart_refresher.dart';

class HomeController extends BaseGetPageController {
  List<TodoListEntity> list = [];
  List<TodoListEntity> systemList = [];

  @override
  void onInit() {
    super.onInit();
    if (SpUtil.getInitString() == "inited") {
      //从数据库获取系统的列表
      getSystemFromDatabase(1);
    } else {
      //将列表存到数据库中
      for (var item in system) {
        MyDatabase.getInstance()!.saveOneList(item);
      }
      SpUtil.saveInitString("inited");
      getSystemFromDatabase(1);
    }
    getSystemFromDatabase(2);
  }

  /*@override
  void requestData(RefreshController controller, {Refresh refresh = Refresh.first}) {
    request.getList(1, success: (data, over) {
      RefreshExtension.onSuccess(controller, refresh, over);
      if (refresh != Refresh.down) {
        systemList.clear();
      }
      systemList.addAll(data);
      showSuccess(systemList);
      update();
    }, fail: (code, msg) {
      showError();
      RefreshExtension.onError(controller, refresh);
    });
  }*/

  void getSystemFromDatabase(int type) async {
    request.getList(type, success: (data, over) {
      if (refresh != Refresh.down) {
        if (type == 1) {
          systemList.clear();
        }
        if (type == 2) {
          list.clear();
        }
      }
      if (type == 1) {
        systemList.addAll(data);
      }
      if (type == 2) {
        list.addAll(data);
        showSuccess(list);
      }
      update();
    }, fail: (code, msg) {
      showError();
    });
  }

  /**
   * type 1 新建 2 完成 3 添加重要性 4 删除
   */
  void updateCount(TodoListEntity entity, int type, int opera,int isMark) {
    if (type == 1) {
      entity.count += 1;
      MyDatabase.getInstance()!.updateToListCount(entity);
      if (entity.id != 4) {
        systemList[3].count += 1;
        MyDatabase.getInstance()!.updateToListCount(systemList[3]);
      }
    } else if (type == 2) {
      if (opera == 0) {
        systemList[4].count -= 1;
        systemList[3].count += 1;
      } else if (opera == 1) {
        systemList[4].count += 1;
        systemList[3].count -= 1;
      }
      MyDatabase.getInstance()!.updateToListCount(systemList[4]);
      MyDatabase.getInstance()!.updateToListCount(systemList[3]);
    } else if (type == 3) {
      if (opera == 0) {
        systemList[1].count -= 1;
      } else {
        systemList[1].count += 1;
      }
      MyDatabase.getInstance()!.updateToListCount(systemList[1]);
    } else {
      entity.count -= 1;
      MyDatabase.getInstance()!.updateToListCount(entity);
      if (entity.id != 4) {
        systemList[3].count -= 1;
        MyDatabase.getInstance()!.updateToListCount(systemList[3]);
      }
      if(entity.id != 5) {
        if(opera == 1) {
          ///已完成的任务需要修改已完成列表
          systemList[4].count -= 1;
          MyDatabase.getInstance()!.updateToListCount(systemList[4]);
        }
      }
      if(entity.id != 2) {
        if (isMark == 1) {
          systemList[1].count -= 1;
          MyDatabase.getInstance()!.updateToListCount(systemList[1]);
        }
      }
    }
    update();
  }

  final system = [
    TodoListEntity(id: 1, title: "我的一天", des: "一天的安排有序进行", createTime: "", bgColor: "0", sortType: 1, type: 1, count: 0),
    TodoListEntity(id: 2, title: "重要", des: "重要的事情需要重点关注", createTime: "", bgColor: "1", sortType: 1, type: 1, count: 0),
    TodoListEntity(id: 3, title: "计划", des: "做好计划,有备无患", createTime: "", bgColor: "2", sortType: 1, type: 1, count: 0),
    TodoListEntity(id: 4, title: "全部", des: "全部任务,一目了然", createTime: "", bgColor: "3", sortType: 1, type: 1, count: 0),
    TodoListEntity(id: 5, title: "已完成", des: "看看你的壮举", createTime: "", bgColor: "4", sortType: 1, type: 1, count: 0),
    TodoListEntity(id: 6, title: "日历", des: "日历视图", createTime: "", bgColor: "5", sortType: 1, type: 1, count: 0),
  ];
}
