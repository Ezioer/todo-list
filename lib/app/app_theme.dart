/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-09 22:30:22
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/theme/app_theme.dart
 */
import 'package:flutter/material.dart';

import '../res/colors.dart';

//自定义主题
class Themes {
  static final light = ThemeData(
      fontFamily: "yuanti",
      useMaterial3: true,
      primaryColor: Colors.white,
      primaryColorLight: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.red, fontSize: 16),
          headlineMedium: TextStyle(color: Colors.black54, fontSize: 18),
          headlineLarge: TextStyle(color: Colors.black, fontSize: 22)),
      appBarTheme: const AppBarTheme(centerTitle: true, iconTheme: IconThemeData(color: Colors.black54)),
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      }));

  static final dark = ThemeData(
    useMaterial3: true,
    //主题色
    primaryColor: Colors.green,
    primaryColorLight: Colors.black38,
    //背景色
    scaffoldBackgroundColor: Colors.blueGrey,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
        headlineSmall: TextStyle(color: ColorStyle.color_d9a40e, fontSize: 16),
        headlineMedium: TextStyle(color: Colors.white70, fontSize: 18),
        headlineLarge: TextStyle(color: Colors.white, fontSize: 22)),
    appBarTheme: AppBarTheme(backgroundColor: Colors.brown),
  );
}
