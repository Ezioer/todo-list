import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/util/save/sp_key.dart';

import '../../model/language.dart';

/// @class : SpUtil
/// @date : 2021/08/19
/// @name : jhf
/// @description :键值对存储
class SpUtil {

  ///删除存储用户信息
  static deleteUserInfo() {
    Get.find<SharedPreferences>().remove(SPKey.keyUserInfo);
  }

  ///存储语言
  ///[Language] 语言
  static updateLanguage(Language language) {
    Get.find<SharedPreferences>().remove(SPKey.language);
    Get.find<SharedPreferences>()
        .setString(SPKey.language, jsonEncode(language.toJson()));
  }

  ///获取语言选项
  ///[Language] 语言
  static Language? getLanguage() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getString(SPKey.language);
      if (json == null) {
        return null;
      } else {
        return Language.fromJson(jsonDecode(json));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }


  /// 搜索历史记录
  /// [word] 搜索记录
  static saveSearchHistory(String word) {
    var history = getSearchHistory();
    if(history.contains(word)){
      return;
    }
    history.insert(0 , word);
    Get.find<SharedPreferences>()
        .setStringList(SPKey.searchHistory, history);
  }

  static saveInitString(String value) {
    Get.find<SharedPreferences>()
        .setString(SPKey.initString, value);
  }

  static String? getInitString() {
   var string =  Get.find<SharedPreferences>()
        .getString(SPKey.initString);
   string ??= "";
   return string;
  }


  ///清空搜索历史
  static void deleteSearchHistory(){
    Get.find<SharedPreferences>().remove(SPKey.searchHistory);
  }

  ///获取搜索历史记录
  static List<String> getSearchHistory() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getStringList(SPKey.searchHistory);
      if (json == null) {
        return [];
      } else {
        return json;
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  ///浏览记录长度
  static int getBrowseHistoryLength() {
    return getBrowseHistory().length;
  }


  ///获取浏览历史记录
  static List<String> getBrowseHistory() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getStringList(SPKey.browseHistory);
      if (json == null) {
        return [];
      } else {
        return json;
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }


}
