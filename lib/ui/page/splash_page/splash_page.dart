import 'package:flutter/material.dart';
import 'package:todos/ui/page/splash_page/widget/splash_ani_widget.dart';

import '../../../res/colors.dart';
import '../../../res/r.dart';
import '../../../util/screen_util.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     ScreenUtil.removeSystemTransparent(context);

    ///预缓存背景图片
    precacheImage(const AssetImage(R.assetsImagesLoginBackground), context);
    return const Scaffold(
      backgroundColor: ColorStyle.color_24CF5F,
      body: SplashAnimWidget(),
    );
  }
}
