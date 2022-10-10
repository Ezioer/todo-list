import 'package:moor/moor.dart';

@DataClassName("todo")
class TodoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get des => text()();
  TextColumn get createTime =>  text()();
  TextColumn get createTimeYMD => text()();

  IntColumn get stopTime => integer()();

  TextColumn get notiTime => text()();
  IntColumn get isMark =>  integer()(); //0 notmark 1 mark
  IntColumn get type =>  integer()(); //所属的分类
  IntColumn get isMyDay =>  integer()();//0 not 1 yes
  IntColumn get isFinish =>  integer()(); //0 not 1 yes
}