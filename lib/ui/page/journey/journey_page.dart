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
import 'journey_controller.dart';

class JourneyPage extends GetCommonView<JourneyController> {
  const JourneyPage({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Theme
            .of(context)
            .colorScheme
            .surfaceVariant);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .surfaceVariant,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed(Routes.addList);
            },
            label: Text("新建"),
            icon: Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .surfaceVariant,
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
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary),
                  ),
                  background: FlutterLogo(),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    FilterChip(
                      label: Text("全部"), onSelected: (bool isSelect) {},),
                    FilterChip(
                      label: Text("动态"), onSelected: (bool isSelect) {},),
                    FilterChip(
                      label: Text("文章"), onSelected: (bool isSelect) {},),
                    FilterChip(
                      label: Text("视频"), onSelected: (bool isSelect) {},)
                  ],
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: GetBuilder<HomeController>(
                    builder: (_) =>
                        SliverList(
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
                Get
                    .find<HomeController>()
                    .list
                    .remove(data);
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
