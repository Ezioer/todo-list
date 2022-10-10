import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateUtil {
  static String getWeeksFromInt(int week) {
    if (week == 1) {
      return "周一";
    } else if (week == 2) {
      return "周二";
    } else if (week == 3) {
      return "周三";
    } else if (week == 4) {
      return "周四";
    } else if (week == 5) {
      return "周五";
    } else if (week == 6) {
      return "周六";
    } else if (week == 7) {
      return "周天";
    }
    return "";
  }

  static int getDayLast(int day) {
    DateTime now = DateTime.now();
    if (day == 7) {
      day = 14 - now.weekday;
    }
    DateTime dateTime = DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0).add(Duration(days: day));
    return dateTime.millisecondsSinceEpoch;
  }

  static String getNotiLast(int day) {
    DateTime now = DateTime.now();
    if(day == 7) {
      day = 14 - now.weekday;
    }
    DateTime dateTime = DateTime(now.year,now.month,now.day,0,0,0,0,0).add(Duration(days: day)).subtract(Duration(hours: 5));
    return dateTime.millisecondsSinceEpoch.toString();
  }

  static String getTodoNoti(int time) {
    if(time == 0 ) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return "${dateTime.month}月${dateTime.day}日,${getWeeksFromInt(dateTime.weekday)} ${dateTime.hour}时 提醒我";
  }


  static String getTimeNoti(int time) {
    // int times = int.parse(time);
    if(time == 0) {
      return "";
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    return "${dateTime.year}年${dateTime.month}月${dateTime.day}日, ${getWeeksFromInt(dateTime.weekday)}到期";
  }
}
