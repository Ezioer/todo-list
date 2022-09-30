import 'dart:io';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos/db/model/todo_entity.dart';
import 'package:todos/db/model/todolist_entity.dart';
import 'package:todos/db/table/todolist_table.dart';
import 'package:todos/db/table/todo_table.dart';

part 'db_manager.g.dart';

@UseMoor(tables: [TodoTable, TodoListTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase._() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static MyDatabase? _instance;

  static MyDatabase? getInstance() {
    _instance ??= MyDatabase._();
    return _instance;
  }

  Future<int> saveOneTodo(TodoEntity entity) async {
    List<todo> single = await (select(todoTable)..where((tbl) => tbl.title.equals(entity.title))).get();
    if (single.isNotEmpty) {
      return -1;
    } else {
     int id =await  into(todoTable).insert(TodoTableCompanion(
          title: Value(entity.title!), des: Value(entity.des!), createTime: Value(entity.createTime!), createTimeYMD:Value(entity.createTimeYMD!),stopTime: Value(entity.stopTime!), notiTime:Value(entity.notiTime!),type: Value(entity.type!), isMark: Value(entity.isMark!), isMyDay: Value(entity.isMyDay!), isFinish: Value(entity.isFinish!)));
      return id;
    }
  }

  void updateTodo(TodoEntity entity) async {
    await update(todoTable).replace(todo(id: entity.id!, title: entity.title!, des: entity.des!, createTime: entity.createTime!, createTimeYMD:entity.createTimeYMD!,stopTime: entity.stopTime!, notiTime:entity.notiTime!,isMark: entity.isMark!, type: entity.type!, isMyDay: entity.isMyDay!, isFinish: entity.isFinish!));
  }

  void updateToListBg(TodoListEntity entity, String bg) async {
    await update(todoListTable).replace(todolist(id: entity.id!, title: entity.title!, des: entity.des!, createTime: entity.createTime!, bgColor: bg, sortType: entity.sortType!, type: entity.type!,count: entity.count));
  }

  void updateToListCount(TodoListEntity entity) async {
    await update(todoListTable).replace(todolist(id: entity.id!, title: entity.title!, des: entity.des!, createTime: entity.createTime!, bgColor: entity.bgColor, sortType: entity.sortType!, type: entity.type!,count: entity.count));
  }

  void deleteTodo(int entity) async {
    var single = await (delete(todoTable)..where((tbl) => tbl.id.equals(entity))).go();
  }

  void deleteTodoList(int id) async {
    var single = await (delete(todoListTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<todo>> findTodo(int type) {
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.type.equals(type))).get();
    return list;
  }

  Future<List<todo>> findTodoByKey(String key) {
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.title.like("%${key}%"))).get();
    return list;
  }

  Future<List<todo>> findCompleted() {
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.isFinish.equals(1))).get();
    return list;
  }

  Future<List<todo>> findAllImportant() {
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.isMark.equals(1))).get();
    return list;
  }

  Future<List<todo>> findAllWork() {
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.isFinish.equals(0))).get();
    return list;
  }

  Future<List<todo>> findToDay() {
    DateTime date = DateTime.now();
    String result = "${date.year}${date.month}${date.day}";
    Future<List<todo>> list = (select(todoTable)..where((tbl) => tbl.createTimeYMD.equals(result))).get();
    return list;
  }

  Future<List<todolist>> getSystemList() {
    Future<List<todolist>> list = (select(todoListTable)..where((tbl) => tbl.type.equals(1))).get();
    return list;
  }

  Future<List<todolist>> getDiyList() {
    Future<List<todolist>> list = (select(todoListTable)..where((tbl) => tbl.type.equals(2))).get();
    return list;
  }

  Future<int> insertDiyList(todolist data) async {
    List<todolist> single = await (select(todoListTable)..where((tbl) => tbl.title.equals(data.title))).get();
    if (single.isNotEmpty) {
      return -1;
    } else {
      int id =await  into(todoListTable).insert(TodoListTableCompanion(title: Value(data.title),des: Value(data.des),createTime: Value(data.createTime),bgColor: Value(data.bgColor)
      ,sortType: Value(data.sortType),type: Value(2),count: Value(data.count)));
      return id;
    }
  }

  Future<void> updateDiyList(todolist data) async {
    await update(todoListTable).replace(data);
  }

  Future<int> saveOneList(TodoListEntity entity) async {
    into(todoListTable).insert(TodoListTableCompanion(title: Value(entity.title!), des: Value(entity.des!), createTime: Value(entity.createTime!), bgColor: Value(entity.bgColor!), sortType: Value(entity.sortType!), type: Value(entity.type!),count: Value(entity.count)));
    return 1;
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
