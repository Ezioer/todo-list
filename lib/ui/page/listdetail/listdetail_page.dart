import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos/base/get/get_common_view.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/res/colors.dart';
import 'package:todos/routes/routes.dart';
import 'package:todos/ui/page/home/home_controller.dart';
import 'package:todos/ui/page/listdetail/listdetail_controller.dart';
import 'package:todos/util/date_util.dart';
import 'package:todos/util/toast_util.dart';

import '../../../res/r.dart';

class ListDetailPage extends GetCommonView<ListDetailController> {
  const ListDetailPage({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // changeNavigatorColor(ColorStyle.colorList[int.parse(controller.defaultBg)]);
    return Scaffold(
      backgroundColor: ColorStyle.colorList[int.parse(controller.defaultBg)],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorStyle.colorList[int.parse(controller.defaultBg)],
            actions: [
              Visibility(
                child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.all(0),
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
                visible: controller.typeEntity.id == 7 ? false : true,
              ),

              /*IconButton(
                  onPressed: () {
                    controller.sortList();
                  },
                  icon: Icon(
                    Icons.sort,
                  )),*/
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
                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 300),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                            ColorStyle.colorList.length,
                                            (index) => InkWell(
                                                  onTap: () {
                                                    controller.changeBg(index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    child: ListTile(
                                                      title: Text(""),
                                                    ),
                                                    margin: EdgeInsets.only(top: 2),
                                                    decoration: BoxDecoration(color: ColorStyle.colorList[index], borderRadius: BorderRadius.circular(20)),
                                                  ),
                                                )),
                                      ),
                                    ),
                                  )
                                  /*ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ColorStyle.colorList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          controller.changeBg(index);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          child: SizedBox(height: 40,),
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(color: ColorStyle.colorList[index], borderRadius: BorderRadius.circular(20)),
                                        ),
                                      );
                                    },
                                  )*/
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.color_lens,
                  )),
              Visibility(
                  visible: controller.typeEntity.type == 1 ? false : true,
                  child: PopupMenuButton(
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
                            _showDialog();
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          onTap: () {
                            MyDatabase.getInstance()!.deleteTodoList(controller.typeEntity.id!);
                            Get.find<HomeController>().update();
                            Navigator.pop(context);
                            finishPage(Get.context!);
                          },
                          leading: Icon(Icons.delete),
                          title: Text('删除'),
                        ),
                      ),
                    ],
                  )),
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
                "${controller.typeEntity.title}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              "${controller.typeEntity.des}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          )),
          SliverVisibility(
            visible: controller.typeEntity.id == 7 ? false : true,
            sliver: GetBuilder<ListDetailController>(
                builder: (_) => SliverList(
                        delegate: SliverChildBuilderDelegate(childCount: controller.todoList.length, (BuildContext context, int index) {
                      return _MyListItem(controller.todoList[index]);
                    }))),
          ),
          SliverToBoxAdapter(
              child: Visibility(
                  visible: (controller.todoList.isNotEmpty || controller.typeEntity.id == 7) ? false : true,
                  child: Container(
                      margin: EdgeInsets.only(top: 100, left: 50, right: 50),
                      child: Column(
                        children: [
                          Lottie.asset(getLottie(controller.typeEntity.id!), width: 200, height: 200, animate: true, repeat: false),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            getNotiText(controller.typeEntity.id!),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )))),
          SliverToBoxAdapter(
            child: Visibility(
                visible: controller.typeEntity.id == 7 ? true : false,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TableCalendar(
                    locale: 'zh_CN',
                    eventLoader: controller.getEventsForDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.selectedDay = selectedDay;
                      controller.focusedDay = focusedDay; // update `_focusedDay` here as well
                      controller.update();
                      if (controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]! == null) {
                        return;
                      }
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
                                        "任务列表",
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      padding: EdgeInsets.all(10),
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(maxHeight: 300),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                                controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]!.length,
                                                (index) => InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Get.toNamed(Routes.commondetail,
                                                            arguments: controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]![index]!);
                                                      },
                                                      child: Container(
                                                        child: ListTile(
                                                            title: Text(controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]![index]!.title!)),
                                                        margin: EdgeInsets.only(top: 2),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                                      ),
                                                    )),
                                          ),
                                        ))

                                    /*ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Get.toNamed(Routes.commondetail,
                                                arguments: controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]![index]!);
                                          },
                                          child: Container(
                                            child: ListTile(title: Text(controller.groupResult["${selectedDay.year}-${selectedDay.month}-${selectedDay.day}"]![index]!.title!)),
                                            margin: EdgeInsets.only(top: 2),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                          ),
                                        );
                                      },
                                    )*/
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        final text = DateFormat.E().format(day);
                        return Center(
                          child: Text(
                            text,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        );
                      },
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),
                )),
          )
        ],
      ),
      floatingActionButton: Visibility(
          visible: (controller.typeEntity.id == 5 || controller.typeEntity.id == 6 || controller.typeEntity.id == 7) ? false : true,
          child: FloatingActionButton(
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
                                          isMark: controller.typeEntity.id == 2 ? 1 : 0,
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
                                GetBuilder<ListDetailController>(
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
                                GetBuilder<ListDetailController>(
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
                                                      lastDate: DateTime(2030, 7),
                                                      helpText: '选择日期',
                                                    );
                                                    if (newDate != null) {
                                                      controller.dateTime = newDate;
                                                      controller.notiTime = newDate.subtract(Duration(hours: 5)).millisecondsSinceEpoch.toString();
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
          )),
    );
  }

  void changeNavigatorColor(Color color) {
    SystemUiOverlayStyle _style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: color,
        systemNavigationBarContrastEnforced: false);
    SystemChrome.setSystemUIOverlayStyle(_style);
  }

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              title: Text("编辑"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      controller.updateDiyList();
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

  void finishPage(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }

  String getLottie(int type) {
    if (type > 7) {
      return R.assetsLottieEmpty;
    }
    if (type == 1) {
      return R.assetsLottieMyDay;
    } else if (type == 2) {
      return R.assetsLottieImportant;
    } else if (type == 3) {
      return R.assetsLottiePlan;
    } else if (type == 4) {
      return R.assetsLottieAll;
    } else if (type == 5) {
      return R.assetsLottieDone;
    } else if (type == 6) {
      return R.assetsLottieEmpty;
    } else {
      return "";
    }
  }

  String getNotiText(int type) {
    if (type == 1) {
      return "使用我的一天完成任务,这是个每天都会刷新的列表";
    } else if (type == 2) {
      return "尝试为一些任务添加星标,以便在此处查看它们";
    } else if (type == 3) {
      return "长远计划的任务可以放在此处";
    } else if (type == 4) {
      return "所有未完成的任务都在这里";
    } else if (type == 5) {
      return "所有已完成的任务都在这里";
    } else if (type == 6) {
      return "所有已过期的任务都在这里";
    } else {
      return "";
    }
  }
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
                          Visibility(
                              child: Icon(
                                Icons.date_range,
                                size: 14,
                              ),
                              visible: data.stopTime == "0" ? false : true),
                          Text(
                            "${DateUtil.getTimeNoti(data.stopTime!)}",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Visibility(
                              child: Icon(
                                Icons.notifications_active,
                                size: 14,
                              ),
                              visible: data.notiTime == "0" ? false : true),
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
/*

List<Event> _getEventsForDay(DateTime day) {
  // Implementation example
  return kEvents[day] ?? [];
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(2, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')));
  */
/*..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });*/ /*


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
*/
