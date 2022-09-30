import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

/// @class : GetCommonView
/// @name : jhf
/// @description :基类,用于绑定Controller
abstract class GetCommonView<T extends GetxController> extends StatefulWidget {
  const GetCommonView({Key? key}) : super(key: key);

  final String? tag = null;
  T get controller => GetInstance().find<T>(tag: tag);

  ///Get 局部更新字段
  get updateId => null;

  @protected
  Widget build(BuildContext context);

  @protected
  void initState();

  @override
  AutoDisposeState createState() => AutoDisposeState<T>();
}

/// @class : AutoDisposeState
/// @name : jhf
/// @description :基类,可自动装载的状态管理
class AutoDisposeState<S extends GetxController> extends State<GetCommonView> {
  AutoDisposeState();

  @override
  Widget build(BuildContext context) {
    changeNavigatorColor(Colors.transparent);
    return GetBuilder<S>(
        id: widget.updateId,
        builder: (controller) {
          return widget.build(context);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<S>();
    super.dispose();
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
}
