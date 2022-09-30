import 'package:moor/moor.dart';

@DataClassName("todolist")
class TodoListTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get des => text()();
  TextColumn get createTime =>  text()();
  TextColumn get bgColor =>  text()();
  IntColumn get sortType => integer()(); //1 时间升序 2 时间降序 3 重要性优先
  IntColumn get type =>  integer()();//1 system 2 diy
  IntColumn get count =>  integer()();
}