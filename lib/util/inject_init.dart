import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/request_repository.dart';

class Injection {
  static Future<void> init() async {
    // shared_preferences
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.lazyPut(() =>RequestRepository());
  }
}