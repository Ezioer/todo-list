import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos/ui/page/splash_page/widget/splash_ani_widget.dart';

import '../../../res/r.dart';
import '../../../util/screen_util.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.removeSystemTransparent(context);
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Theme.of(context).colorScheme.surfaceVariant);

    ///预缓存背景图片
    precacheImage(const AssetImage(R.assetsImagesLoginBackground), context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: SplashAnimWidget(),
      ),
    );
  }
}
