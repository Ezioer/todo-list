import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:todos/base/get/get_common_view.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/res/colors.dart';
import 'package:todos/ui/page/addlist/addlist_controller.dart';
import 'package:todos/ui/page/listdetail/listdetail_controller.dart';
import 'package:todos/util/toast_util.dart';
import 'package:todos/widget/pull_smart_refresher.dart';

import '../../../routes/routes.dart';
import '../../../util/date_util.dart';
import '../home/home_controller.dart';

class AddListPage extends GetCommonView<AddListController> {
  const AddListPage({Key? key}) : super(key: key);

  @override
  AutoDisposeState<GetxController> createState() {
    // TODO: implement createState
    Future.delayed(Duration.zero, () {
      _showDialog(1);
    });
    return super.createState();
  }

  void _showDialog(int type) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              title: Text("${type == 1? "新建列表" : "编辑"}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if(type == 1) {
                        finishPage(Get.context!);
                      }
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if(type == 1) {
                        controller.addDiyList();
                      } else {
                        controller.updateDiyList();
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.circle),
                      hintText: "列表名称",
                    ),
                    controller: controller.titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.circle),
                      hintText: "来句简短描述吧",
                    ),
                    controller: controller.desController,
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    // showNewListDialog(context);
    return Scaffold(
      backgroundColor: ColorStyle.colorList[int.parse(controller.defaultBg)],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorStyle.colorList[int.parse(controller.defaultBg)],
            actions: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                padding: EdgeInsets.all(4),
                icon: Icon(Icons.sort),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.sort),
                      title: Text('时间升序'),
                      onTap: () {
                        controller.sortList(1);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        controller.sortList(2);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.sort),
                      title: Text('时间降序'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        controller.sortList(3);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.star),
                      title: Text('重要性优先'),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        builder: (context) {
                          return Wrap(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "选择主题",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ColorStyle.colorList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          controller.changeBg(index);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 2),
                                          width: 40,
                                          height: 30,
                                          decoration: BoxDecoration(color: ColorStyle.colorList[index], borderRadius: BorderRadius.circular(20)),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.color_lens,
                  )),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                padding: EdgeInsets.all(4),
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('重命名列表'),
                      onTap: () {
                        Navigator.pop(context);
                        _showDialog(2);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        MyDatabase.getInstance()!.deleteTodoList(controller.typeEntity.id!);
                        Get.find<HomeController>().getSystemFromDatabase(2);
                        Navigator.pop(context);
                        finishPage(Get.context!);
                      },
                      leading: Icon(Icons.delete),
                      title: Text('删除'),
                    ),
                  ),
                ],
              ),
            ],
            centerTitle: true,
            elevation: 0,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 120,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16.0),
              title: Text(
                "${controller.titleController.text}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              "${controller.desController.text}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          )),
          SliverPadding(
            padding: EdgeInsets.only(top: 10),
            sliver: GetBuilder<AddListController>(
                builder: (_) => SliverList(
                        delegate: SliverChildBuilderDelegate(childCount: controller.todoList.length, (BuildContext context, int index) {
                      return _MyListItem(controller.todoList[index]);
                    }))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.circle),
                                  hintText: "在${controller.typeEntity.title}里添加任务",
                                ),
                                controller: controller.textController,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  TodoEntity entity = TodoEntity(
                                      id: 0,
                                      title: controller.textController.text,
                                      des: "",
                                      createTime: DateTime.now().millisecondsSinceEpoch.toString(),
                                      createTimeYMD: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                                      stopTime: controller.stopTime,
                                      notiTime: controller.notiTime,
                                      isMark: 0,
                                      type: controller.typeEntity.id,
                                      isMyDay: controller.typeEntity.id == 1 ? 1 : 0,
                                      isFinish: 0);
                                  int result = await MyDatabase.getInstance()!.saveOneTodo(entity);
                                  if (result == -1) {
                                    ToastUtils.show("不要添加相同任务哦");
                                  } else {
                                    entity.id = result;
                                    controller.todoList.add(entity);
                                    controller.update();
                                    Get.find<HomeController>().updateCount(controller.typeEntity, 1, 0, 0, entity.type!);
                                    Navigator.pop(context);
                                  }
                                },
                                icon: Icon(Icons.send))
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GetBuilder<AddListController>(
                              builder: (_) => InputChip(
                                backgroundColor: controller.isDeleteStopTime == 1 ? Colors.red : null,
                                deleteIcon: null,
                                onDeleted: controller.isDeleteStopTime == 1
                                    ? () {
                                        controller.changeIsDelete(0, "设置截至日期");
                                      }
                                    : null,
                                avatar: Icon(Icons.date_range),
                                label: Text("${controller.stopValue}"),
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
                                              title: Text('今天（${DateUtil.getWeeksFromInt(DateTime.now().weekday)}）'),
                                              onTap: () {
                                                controller.changeIsDelete(1, "今天 到期");
                                                controller.stopTime = DateUtil.getDayLast(1);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.calendar_today_outlined),
                                              title: Text('明天（${DateUtil.getWeeksFromInt(DateTime.now().add(Duration(days: 1)).weekday)}）'),
                                              onTap: () {
                                                controller.changeIsDelete(1, "明天 到期");
                                                controller.stopTime = DateUtil.getDayLast(2);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.calendar_today_outlined),
                                              title: Text('下周（星期日）'),
                                              onTap: () {
                                                controller.changeIsDelete(1, "下周 到期");
                                                controller.stopTime = DateUtil.getDayLast(7);
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
                                                  controller.stopTime = newDate.add(Duration(days: 1)).millisecondsSinceEpoch;
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
                              width: 10,
                            ),
                            GetBuilder<AddListController>(
                              builder: (_) => InputChip(
                                backgroundColor: controller.isDeleteNoti == 1 ? Colors.red : null,
                                deleteIcon: null,
                                onDeleted: controller.isDeleteNoti == 1
                                    ? () {
                                        controller.changeIsNoti(0, "提醒我");
                                      }
                                    : null,
                                avatar: Icon(Icons.notifications_active),
                                label: Text("${controller.notiValue}"),
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
                                                controller.changeIsNoti(1, "今天(19:00)提醒我");
                                                controller.notiTime = DateUtil.getNotiLast(1);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.access_time),
                                              title: Text('明天(19:00)'),
                                              onTap: () {
                                                controller.changeIsNoti(1, "明天(19:00)提醒我");
                                                controller.notiTime = DateUtil.getNotiLast(2);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.access_time),
                                              title: Text('下周天(19:00)'),
                                              onTap: () {
                                                controller.changeIsNoti(1, "下周天(19:00)提醒我");
                                                controller.notiTime = DateUtil.getNotiLast(7);
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
                                                  controller.notiTime = newDate
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
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {}

  void finishPage(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }
}

void showNewListDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            title: Text("新建列表"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Get.find<AddListController>().addDiyList();
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
            content: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.circle),
                    hintText: "列表名称",
                  ),
                  controller: Get.find<AddListController>().titleController,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.circle),
                    hintText: "来句简短描述吧",
                  ),
                  controller: Get.find<AddListController>().desController,
                ),
              ],
            ));
      });
}

class _MyListItem extends StatelessWidget {
  final TodoEntity data;

  const _MyListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(1),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(
          onDismissed: () {
            MyDatabase.getInstance()!.deleteTodo(data.id!);
            Get.find<HomeController>().updateCount(Get.find<ListDetailController>().typeEntity, 4, data.isFinish!, data.isMark!, data.type!);
          },
        ),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            autoClose: false,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (BuildContext context) {
              Slidable.of(context)?.dismiss(ResizeRequest(Duration(milliseconds: 800), () {
                MyDatabase.getInstance()!.deleteTodo(data.id!);
                Get.find<ListDetailController>().todoList.remove(data);
                Get.find<HomeController>().updateCount(Get.find<ListDetailController>().typeEntity, 4, data.isFinish!, data.isMark!, data.type!);
                Get.find<ListDetailController>().update();
              }));
            },
          ),
        ],
      ),
      child: Material(
          color: Colors.transparent,
          child: Container(
            height: 68,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
                child: InkWell(
              onTap: () => {Get.toNamed(Routes.commondetail, arguments: data)},
              child: Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    onChanged: (value) {
                      if (data.isFinish == 1) {
                        data.isFinish = 0;
                      } else {
                        data.isFinish = 1;
                      }
                      Get.find<ListDetailController>().updateTaskStatus(data);
                      Get.find<HomeController>().updateCount(Get.find<ListDetailController>().typeEntity, 2, data.isFinish!, 0, data.type!);
                      Get.find<ListDetailController>().update();
                    },
                    value: data.isFinish == 1,
                    activeColor: Color(0xFF6200EE),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${data.title}", style: TextStyle(fontSize: 16, decoration: data.isFinish == 1 ? TextDecoration.lineThrough : null)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(child: Icon(Icons.date_range,size: 14,),visible: data.stopTime == "0" ? false : true) ,
                          Text(
                            "${DateUtil.getTimeNoti(data.stopTime!)}",
                            style: TextStyle(fontSize: 11),
                          ),
                          SizedBox(width: 12,),
                          Visibility(child: Icon(Icons.notifications_active,size: 14,),visible: data.notiTime == "0" ? false : true) ,
                        ],
                      )
                    ],
                  )),
                  IconButton(
                    onPressed: () {
                      if (data.isMark == 1) {
                        data.isMark = 0;
                      } else {
                        data.isMark = 1;
                      }
                      Get.find<ListDetailController>().updateTaskStatus(data);
                      Get.find<HomeController>().updateCount(Get.find<ListDetailController>().typeEntity, 3, data.isMark!, 0, data.type!);
                      Get.find<ListDetailController>().update();
                    },
                    icon: Icon(data.isMark == 1 ? Icons.star : Icons.star_border),
                    color: data.isMark == 1 ? Colors.red : null,
                  )
                ],
              )),
            )),
          )),
    );
  }
}
