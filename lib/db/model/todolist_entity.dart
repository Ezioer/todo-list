import 'dart:convert';

TodoListEntity ListFromJson(String str) => TodoListEntity.fromJson(json.decode(str));

String ListToJson(TodoListEntity listEntity) => json.encode(listEntity.toJson());

class TodoListEntity {
  int? id;
  String? title;
  String? des;
  String? createTime;
  String bgColor = "0";
  int? sortType;
  int? type;
  int count = 0;

  TodoListEntity({this.id, this.title, this.des, this.createTime,required this.bgColor,this.sortType,this.type,required this.count});

  TodoListEntity.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    des = json['des'];
    createTime = json['createTime'];
    bgColor = json['bgColor'];
    sortType = json['sortType'];
    type = json['type'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['des'] = des;
    map['createTime'] = createTime;
    map['bgColor'] = bgColor;
    map['sortType'] = sortType;
    map['type'] = type;
    map['count'] = count;
    return map;
  }
}
