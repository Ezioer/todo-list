import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todos/base/get/get_common_view.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/res/colors.dart';
import 'package:todos/ui/page/home/home_controller.dart';
import 'package:todos/ui/page/listdetail/listdetail_controller.dart';
import 'package:todos/ui/page/tododetail/tododetail_controller.dart';
import 'package:todos/util/toast_util.dart';

import '../../../util/date_util.dart';

class TodoDetailPage extends GetCommonView<TodoDetailController> {
  const TodoDetailPage({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: () {
            MyDatabase.getInstance()!.deleteTodo(controller.data.id!);
            Get.find<ListDetailController>().todoList.remove(controller.data);
            Get.find<HomeController>().updateCount( Get.find<ListDetailController>().typeEntity, 4, controller.data.isFinish!,controller.data.isMark!);
            Get.find<ListDetailController>().update();
            finishPage(context);
          }, icon: Icon(Icons.delete)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: 68,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      onChanged: (value) {
                        if (controller.data.isFinish == 1) {
                          controller.data.isFinish = 0;
                        } else {
                          controller.data.isFinish = 1;
                        }
                        Get.find<TodoDetailController>().updateTaskStatus(controller.data);
                        Get.find<HomeController>().updateCount(Get
                            .find<ListDetailController>()
                            .typeEntity, 2, controller.data.isFinish!,0);
                        Get.find<TodoDetailController>().update();
                        Get.find<ListDetailController>().update();
                      },
                      value: controller.data.isFinish == 1,
                      activeColor: Color(0xFF6200EE),
                    ),
                    Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 16, fontWeight:FontWeight.bold,decoration: controller.data.isFinish == 1 ? TextDecoration.lineThrough : null),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          controller: controller.titleController,
                        ),
                      // child: Text("${controller.data.title}", style: TextStyle(fontSize: 16, decoration: controller.data.isFinish == 1 ? TextDecoration.lineThrough : null)),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controller.data.isMark == 1) {
                          controller.data.isMark = 0;
                        } else {
                          controller.data.isMark = 1;
                        }
                        Get.find<TodoDetailController>().updateTaskStatus(controller.data);
                        Get.find<HomeController>().updateCount(Get
                            .find<ListDetailController>()
                            .typeEntity, 3, controller.data.isMark!,0);
                        Get.find<TodoDetailController>().update();
                        Get.find<ListDetailController>().update();
                      },
                      icon: Icon(controller.data.isMark == 1 ? Icons.star : Icons.star_border),
                      color: controller.data.isMark == 1 ? Colors.red : null,
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 250,
              child: SingleChildScrollView(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintText: "备注",
                  ),
                  maxLines: null,
                  controller: controller.desController,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<TodoDetailController>(
                    builder: (_) =>
                        InputChip(
                          backgroundColor: controller.isDeleteStopTime == 1 ? Colors.red : null,
                          deleteIcon: null,
                          onDeleted: controller.isDeleteStopTime == 1
                              ? () {
                            controller.changeIsDelete(0, "设置截至日期");
                          }
                              : null,
                          avatar: Icon(Icons.date_range),
                          label: Text(
                            "${DateUtil.getTimeNoti(int.parse(controller.data.stopTime!))}",
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.calendar_today_outlined),
                                        title: Text('今天（${DateUtil.getWeeksFromInt(DateTime
                                            .now()
                                            .weekday)}）'),
                                        onTap: () {
                                          controller.data.stopTime = DateUtil.getDayLast(1);
                                          controller.changeIsDelete(1, "今天 到期");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today_outlined),
                                        title: Text('明天（${DateUtil.getWeeksFromInt(DateTime
                                            .now()
                                            .add(Duration(days: 1))
                                            .weekday)}）'),
                                        onTap: () {
                                          controller.data.stopTime = DateUtil.getDayLast(2);
                                          controller.changeIsDelete(1, "明天 到期");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today_outlined),
                                        title: Text('下周（星期日）'),
                                        onTap: () {
                                          controller.data.stopTime = DateUtil.getDayLast(7);
                                          controller.changeIsDelete(1, "下周 到期");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today_outlined),
                                        title: Text('选择日期'),
                                        onTap: () async {
                                          final DateTime? newDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2017, 1),
                                            lastDate: DateTime(2025, 7),
                                            helpText: 'Select a date',
                                          );
                                          if (newDate != null) {
                                            controller.dateTime = newDate;
                                            controller.data.stopTime = newDate
                                                .add(Duration(days: 1))
                                                .millisecondsSinceEpoch
                                                .toString();
                                            controller.changeIsDelete(1, "${newDate.year}-${newDate.month}-${newDate.day} 到期");
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<TodoDetailController>(
                    builder: (_) =>
                        InputChip(
                          backgroundColor: controller.isDeleteNoti == 1 ? Colors.red : null,
                          deleteIcon: null,
                          onDeleted: controller.isDeleteNoti == 1
                              ? () {
                            controller.changeIsNoti(0, "提醒我");
                          }
                              : null,
                          avatar: Icon(Icons.notifications_active),
                          label: Text("${DateUtil.getTodoNoti(int.parse(controller.data.notiTime!))}"),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.access_time),
                                        title: Text('今天(19:00)'),
                                        onTap: () {
                                          controller.data.notiTime = DateUtil.getNotiLast(1);
                                          controller.changeIsNoti(1, "今天(19:00)提醒我");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.access_time),
                                        title: Text('明天(19:00)'),
                                        onTap: () {
                                          controller.data.notiTime = DateUtil.getNotiLast(2);
                                          controller.changeIsNoti(1, "明天(19:00)提醒我");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.access_time),
                                        title: Text('下周天(19:00)'),
                                        onTap: () {
                                          controller.data.notiTime = DateUtil.getNotiLast(7);
                                          controller.changeIsNoti(1, "下周天(19:00)提醒我");
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.access_time),
                                        title: Text('选择日期'),
                                        onTap: () async {
                                          final DateTime? newDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2017, 1),
                                            lastDate: DateTime(2025, 7),
                                            helpText: '选择日期',
                                          );
                                          if (newDate != null) {
                                            controller.dateTime = newDate;
                                            controller.data.notiTime = newDate
                                                .subtract(Duration(hours: 5))
                                                .millisecondsSinceEpoch
                                                .toString();
                                            controller.changeIsNoti(1, "${newDate.year}-${newDate.month}-${newDate.day}(19:00)提醒我");
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                  )
                ],
              ),
            ),
            // Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15),
              color: Colors.blueGrey,
              height: 1,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only( top: 15),
              child: Text("${getTimeFromMill(controller.data.createTime!)}",style: TextStyle(color: Colors.black45),),
            )
          ],
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          onPressed: () {
            ///保存修改
            controller.data.title = controller.titleController?.text;
            controller.data.des = controller.desController?.text;
            Get.find<TodoDetailController>().updateTaskStatus(controller.data);
            Get.find<ListDetailController>().update();
            ToastUtils.show("修改成功");
          },
          label: Text("完成"),
          icon: Icon(Icons.done),
        ),
        visible: true,
      ),
    );
  }

  String getTimeFromMill(String time) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return "创建于 ${date.year} 年 ${date.month} 月 ${date.day}日 ${DateUtil.getWeeksFromInt(date.weekday)}";
  }
}

void finishPage(BuildContext context) {
  Future.delayed(Duration.zero, () {
    Navigator.pop(context);
  });
}
