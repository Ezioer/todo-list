import 'dart:convert';

TodoEntity TodoFromJson(String str) => TodoEntity.fromJson(json.decode(str));

String TodoToJson(TodoEntity todoEntity) => json.encode(todoEntity.toJson());

class TodoEntity {
  int? id;
  String? title;
  String? des;
  String? createTime;
  String? createTimeYMD;
  String stopTime = "0";
  String notiTime = "0";
  int? type;
  int? isMark;
  int? isMyDay;
  int? isFinish;

  TodoEntity({this.id, this.title, this.des, this.createTime,this.createTimeYMD,required this.stopTime,required this.notiTime,this.type,this.isMark,this.isMyDay,this.isFinish});

  TodoEntity.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    des = json['des'];
    createTime = json['createTime'];
    createTimeYMD = json['createTimeYMD'];
    stopTime = json['stopTime'];
    notiTime = json['notiTime'];
    type = json['type'];
    isMark = json['isMark'];
    isMyDay = json['isMyDay'];
    isFinish = json['isFinish'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['des'] = des;
    map['createTime'] = createTime;
    map['createTimeYMD'] = createTimeYMD;
    map['stopTime'] = stopTime;
    map['notiTime'] = notiTime;
    map['type'] = type;
    map['isMark'] = isMark;
    map['isMyDay'] = isMyDay;
    map['isFinish'] = isFinish;
    return map;
  }
}
