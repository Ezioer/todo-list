import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos/base/get/get_common_view.dart';
import 'package:todos/db/db_manager.dart';
import 'package:todos/db/model/todolist_entity.dart';
import 'package:todos/ui/page/home/home_controller.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';
import '../../../routes/routes.dart';

class HomePage extends GetCommonView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Theme.of(context).colorScheme.surfaceVariant);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed(Routes.addList);
            },
            label: Text("新建列表"),
            icon: Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.searchPage);
                      },
                      icon: Icon(
                        Icons.search,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                      )),
                ],
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 160,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Todo",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  background: FlutterLogo(),
                ),
              ),
              SliverToBoxAdapter(
                  child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[0].bgColor!)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[0]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_view_day,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[0].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text("我的一天",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${controller.systemList[0].count == 0 ? "" : controller.systemList[0].count}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[1].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[1]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[1].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text("重要",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${controller.systemList[1].count == 0 ? "" : controller.systemList[1].count}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[2].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[2]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[2].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text("计划",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${controller.systemList[2].count == 0 ? "" : controller.systemList[2].count}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[3].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[3]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.all_inclusive_outlined,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[3].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text("未完成",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${controller.systemList[3].count == 0 ? "" : controller.systemList[3].count}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[4].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[4]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[4].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text("已完成",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ),
                                Text(
                                    "${controller.systemList[4].count == 0 ? "" : controller.systemList[4].count}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[5].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[5]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[5].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "已过期",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text("",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      InkWell(
                          splashColor: ColorStyle.colorList[
                              int.parse(controller.systemList[6].bgColor)],
                          onTap: () {
                            Get.toNamed(Routes.listdetailPage,
                                arguments: controller.systemList[6]);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: ColorStyle.iconColorList[int.parse(
                                      controller.systemList[6].bgColor)],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "日历",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text("",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                            left: 12, right: 16, top: 16, bottom: 16),
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              )),
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: GetBuilder<HomeController>(
                    builder: (_) => SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: controller.list.length,
                            (BuildContext context, int index) {
                      return _MyListItem(controller.list[index]);
                    })),
                  ))
            ],
          )),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final TodoListEntity data;

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
            MyDatabase.getInstance()!.deleteTodoList(data.id!);
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
            onPressed: (BuildContext context) {
              Slidable.of(context)
                  ?.dismiss(ResizeRequest(Duration(milliseconds: 800), () {
                MyDatabase.getInstance()!.deleteTodoList(data.id!);
                Get.find<HomeController>().list.remove(data);
                Get.find<HomeController>().update();
              }));
            },
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: ColorStyle.colorList[int.parse(data.bgColor)],
            onTap: () {
              Get.toNamed(Routes.listdetailPage, arguments: data);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 16.0),
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.my_library_add,
                    color: ColorStyle.colorList[int.parse(data.bgColor)],
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Text(
                      "${data.title}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text("${data.count == 0 ? "" : data.count}",
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            )),
      ),
    );
  }
}
