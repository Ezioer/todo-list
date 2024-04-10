import 'package:get/get.dart';
import 'package:todos/ui/page/addlist/addlist_binding.dart';
import 'package:todos/ui/page/addlist/addlist_page.dart';
import 'package:todos/ui/page/journey/journey_binding.dart';
import 'package:todos/ui/page/journey/journey_page.dart';
import 'package:todos/ui/page/listdetail/listdetail_binding.dart';
import 'package:todos/ui/page/listdetail/listdetail_page.dart';
import 'package:todos/ui/page/search/search_binding.dart';
import 'package:todos/ui/page/search/search_page.dart';
import 'package:todos/ui/page/tododetail/tododetail_binding.dart';
import 'package:todos/ui/page/tododetail/tododetail_page.dart';

import '../ui/page/home/home_binding.dart';
import '../ui/page/home/home_page.dart';
import '../ui/page/splash_page/splash_binding.dart';
import '../ui/page/splash_page/splash_page.dart';

/// @class : Routes
/// @name : jhf
/// @description :页面管理
abstract class Routes {
  ///入口模块
  static const String splashPage = '/splash';

  ///主页
  static const String homePage = '/home';
  static const String listdetailPage = '/listdetail';
  static const String searchPage = '/search';
  static const String addList = '/addlist';
  static const String journey = '/journey';

  static const String about = '/about';
  static const String commondetail = '/commondetail';
  static const String setting = '/setting';

  ///页面合集
  static final routePage = [
    GetPage(
        name: splashPage,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: homePage,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: listdetailPage,
        page: () => const ListDetailPage(),
        binding: ListDetailBinding()),
    GetPage(
        name: searchPage,
        page: () => const SearchPage(),
        binding: SearchBinding()),
    GetPage(
        name: addList,
        page: () => const AddListPage(),
        binding: AddListBinding()),
    GetPage(
        name: commondetail,
        page: () => const TodoDetailPage(),
        binding: TodoDetailBinding()),
    GetPage(
        name: journey,
        page: () => const JourneyPage(),
        binding: JourneyBinding()),
  ];
}
