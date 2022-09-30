import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todos/app/app_theme.dart';
import 'package:todos/res/strings.dart';
import 'package:todos/routes/routes.dart';
import 'package:todos/ui/page/splash_page/splash_binding.dart';
import 'package:todos/ui/page/splash_page/splash_page.dart';
import 'package:todos/util/inject_init.dart';
import 'package:todos/util/keyboard_util.dart';
import 'package:todos/util/locale_util.dart';

const Set<PointerDeviceKind> _kTouchLikeDeviceTypes = <PointerDeviceKind>{
  PointerDeviceKind.touch,
  PointerDeviceKind.mouse,
  PointerDeviceKind.stylus,
  PointerDeviceKind.invertedStylus,
  PointerDeviceKind.unknown
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  initializeDateFormatting().then((_) => runApp(GetMaterialApp(
    scrollBehavior: const MaterialScrollBehavior()
        .copyWith(scrollbars: true, dragDevices: _kTouchLikeDeviceTypes),
    getPages: Routes.routePage,
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    builder: (context, child) => Scaffold(
      // Global GestureDetector that will dismiss the keyboard
      body: GestureDetector(
        onTap: () {
          KeyboardUtils.hideKeyboard(context);
        },
        child: child,
      ),
    ),

    ///主题颜色
    theme: Themes.light,

    ///国际化支持-来源配置
    translations: Messages(),

    ///国际化支持-默认语言
    locale: LocaleOptions.getDefault(),

    ///国际化支持-备用语言
    fallbackLocale: const Locale('en', 'US'),
    defaultTransition: Transition.rightToLeftWithFade,
    initialBinding: SplashBinding(),
    home: const SplashPage(),
  )));
}
