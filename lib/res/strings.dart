import 'package:get/get.dart';

/// @class : StringStyles
/// @name : jhf
/// @description :字符管理
class StringStyles{

  static const String appName = 'appName';
  static const String loading = 'loading';

  static const String settingTitle = "settingTitle";
  static const String settingLanguage = "settingLanguage";
  static const String settingLanguageDefault = "settingLanguageDefault";
  static const String settingCache = "settingCache";
  static const String settingCacheSuccess = "settingCacheSuccess";
  static const String settingCacheFail = "settingCacheFail";

  static const String enter = "enter";
  static const String quit = "quit";
  static const String pointsNotifySuccess = "pointsNotifySuccess";
  static const String homeMore = "homeMore";
  static const String homeToday = "homeToday";
  static const String homeMy = "homeMy";

  static const String meHistory = "meHistory";
  static const String meCollect = "meCollect";
  static const String meAbout = "meAbout";
  static const String meModelDay = "meModelDay";
  static const String meModelNight = "meModelNight";

  static const String refreshNoData = "refreshNoData";
  static const String refreshError = "refreshError";
  static const String refreshPull = "refreshPull";
  static const String refreshHeaderIdle = "refreshHeaderIdle";
  static const String refreshHeaderFailed = "refreshHeaderFailed";
  static const String refreshHeaderSuccess = "refreshHeaderSuccess";
  static const String refreshHeaderFreed = "refreshHeaderFreed";
  static const String refreshEmpty = "refreshEmpty";
}

///使用Get配置语言环境
///使用Get.updateLocale(locale);即可更新
class Messages extends Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    'zh_CN' : {
          StringStyles.appName: 'todo list',
          StringStyles.loading: '加载中...',
          StringStyles.settingTitle: "设置",
          StringStyles.settingLanguage: "语言",
          StringStyles.settingLanguageDefault: "跟随系统",
          StringStyles.settingCache: "清除缓存",
          StringStyles.settingCacheSuccess: "清除缓存成功!",
          StringStyles.settingCacheFail: "清除缓存失败!",
          StringStyles.enter: "确认",
          StringStyles.quit: "取消",
          StringStyles.pointsNotifySuccess: "刷新成功",
          StringStyles.homeMore: "诗词",
          StringStyles.homeToday: "推荐",
          StringStyles.homeMy: "我的",
          StringStyles.meAbout: "关于",
          StringStyles.meCollect: "收藏",
          StringStyles.meHistory: "历史",
          StringStyles.meModelDay: "纯白",
          StringStyles.meModelNight: "暗黑",
          StringStyles.refreshNoData: "没有更多数据啦",
          StringStyles.refreshError: "加载失败!",
          StringStyles.refreshPull: "下拉加载",
          StringStyles.refreshHeaderIdle: "上拉刷新",
          StringStyles.refreshHeaderFreed: "释放刷新",
          StringStyles.refreshHeaderFailed: "刷新失败!",
          StringStyles.refreshHeaderSuccess: "刷新成功",
        },
    'zh_HK' : {
          StringStyles.appName: 'todo list',
          StringStyles.loading: '加載中...',
          StringStyles.settingTitle: "設置",
          StringStyles.settingLanguage: "語言",
          StringStyles.settingLanguageDefault: "跟隨系統",
          StringStyles.settingCache: "清除緩存",
          StringStyles.settingCacheSuccess: "清除緩存成功!",
          StringStyles.settingCacheFail: "清除緩存失敗!",
          StringStyles.enter: "確認",
          StringStyles.quit: "取消",
          StringStyles.pointsNotifySuccess: "刷新成功",
          StringStyles.homeMore: "诗词",
          StringStyles.homeToday: "推荐",
          StringStyles.homeMy: "我的",
          StringStyles.meAbout: "关于",
          StringStyles.meCollect: "收藏",
          StringStyles.meHistory: "历史",
          StringStyles.meModelDay: "纯白",
          StringStyles.meModelNight: "暗黑",
          StringStyles.refreshNoData: "沒有更多數據啦",
          StringStyles.refreshError: "加載失敗!",
          StringStyles.refreshPull: "下拉加載",
          StringStyles.refreshHeaderIdle: "上拉刷新",
          StringStyles.refreshHeaderFreed: "釋放刷新",
          StringStyles.refreshHeaderFailed: "刷新失敗!",
          StringStyles.refreshHeaderSuccess: "刷新成功",
        },
    'en_US' : {
          StringStyles.appName: 'todo list',
          StringStyles.loading: 'Loading...',
          StringStyles.settingTitle: "Setting",
          StringStyles.settingLanguage: "Language",
          StringStyles.settingLanguageDefault: "Follow System",
          StringStyles.settingCache: "Clear cache",
          StringStyles.settingCacheSuccess: "Clear cache successfully!",
          StringStyles.settingCacheFail: "Failed to clear cache!",
          StringStyles.enter: "Confirm",
          StringStyles.quit: "Quit",
          StringStyles.pointsNotifySuccess: "Refresh successfully",
          StringStyles.homeMore: "Poetry",
          StringStyles.homeToday: "Recommend",
          StringStyles.homeMy: "Mine",
          StringStyles.meAbout: "About",
          StringStyles.meCollect: "Collect",
          StringStyles.meHistory: "History",
          StringStyles.meModelDay: "Pure White",
          StringStyles.meModelNight: "Dark Black",
          StringStyles.refreshNoData: "No more data",
          StringStyles.refreshError: "Failed to load!",
          StringStyles.refreshPull: "Drop-down loading",
          StringStyles.refreshHeaderIdle: "Pull up to refresh",
          StringStyles.refreshHeaderFreed: "Release refresh",
          StringStyles.refreshHeaderFailed: "Refresh failed!",
          StringStyles.refreshHeaderSuccess: "Refresh successfully",
        }
      };

}

