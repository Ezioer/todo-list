import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todos/base/get/get_common_view.dart';
import 'package:todos/color_schemes.g.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/ui/page/listdetail/listdetail_controller.dart';
import 'package:todos/ui/page/search/search_controller.dart';

import '../../../res/r.dart';
import '../../../routes/routes.dart';
import '../../../util/date_util.dart';
import '../home/home_controller.dart';

class SearchPage extends GetCommonView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "搜索你的任务",
                          ),
                          controller: controller.textController,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.searchResult(controller.textController.text);
                          },
                          icon: Icon(Icons.search))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: controller.list.isEmpty ? false : true,
                      child: Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _MyListItem(controller.list[index]);
                          },
                        ),
                      )),
                  Visibility(
                    child: Expanded(
                      child: Lottie.asset(R.assetsLottieSearch, width: 200, height: 200, animate: true),
                    ),
                    visible: controller.list.isEmpty ? true : false,
                  ),
                ],
              ),
            )));
  }
}

class _MyListItem extends StatelessWidget {
  final TodoEntity data;

  const _MyListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                                      style: TextStyle(fontSize: 11),
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
        ));
  }
}
