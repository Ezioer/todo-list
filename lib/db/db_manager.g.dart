// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_manager.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class todo extends DataClass implements Insertable<todo> {
  final int id;
  final String title;
  final String des;
  final String createTime;
  final String createTimeYMD;
  final int stopTime;
  final String notiTime;
  final int isMark;
  final int type;
  final int isMyDay;
  final int isFinish;

  todo(
      {required this.id,
      required this.title,
      required this.des,
      required this.createTime,
      required this.createTimeYMD,
      required this.stopTime,
      required this.notiTime,
      required this.isMark,
      required this.type,
      required this.isMyDay,
      required this.isFinish});
  factory todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return todo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      des: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}des'])!,
      createTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_time'])!,
      createTimeYMD: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}create_time_y_m_d'])!,
      stopTime: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}stop_time'])!,
      notiTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}noti_time'])!,
      isMark: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_mark'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      isMyDay: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_my_day'])!,
      isFinish: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_finish'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['des'] = Variable<String>(des);
    map['create_time'] = Variable<String>(createTime);
    map['create_time_y_m_d'] = Variable<String>(createTimeYMD);
    map['stop_time'] = Variable<int>(stopTime);
    map['noti_time'] = Variable<String>(notiTime);
    map['is_mark'] = Variable<int>(isMark);
    map['type'] = Variable<int>(type);
    map['is_my_day'] = Variable<int>(isMyDay);
    map['is_finish'] = Variable<int>(isFinish);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      id: Value(id),
      title: Value(title),
      des: Value(des),
      createTime: Value(createTime),
      createTimeYMD: Value(createTimeYMD),
      stopTime: Value(stopTime),
      notiTime: Value(notiTime),
      isMark: Value(isMark),
      type: Value(type),
      isMyDay: Value(isMyDay),
      isFinish: Value(isFinish),
    );
  }

  factory todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      des: serializer.fromJson<String>(json['des']),
      createTime: serializer.fromJson<String>(json['createTime']),
      createTimeYMD: serializer.fromJson<String>(json['createTimeYMD']),
      stopTime: serializer.fromJson<int>(json['stopTime']),
      notiTime: serializer.fromJson<String>(json['notiTime']),
      isMark: serializer.fromJson<int>(json['isMark']),
      type: serializer.fromJson<int>(json['type']),
      isMyDay: serializer.fromJson<int>(json['isMyDay']),
      isFinish: serializer.fromJson<int>(json['isFinish']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'des': serializer.toJson<String>(des),
      'createTime': serializer.toJson<String>(createTime),
      'createTimeYMD': serializer.toJson<String>(createTimeYMD),
      'stopTime': serializer.toJson<int>(stopTime),
      'notiTime': serializer.toJson<String>(notiTime),
      'isMark': serializer.toJson<int>(isMark),
      'type': serializer.toJson<int>(type),
      'isMyDay': serializer.toJson<int>(isMyDay),
      'isFinish': serializer.toJson<int>(isFinish),
    };
  }

  todo copyWith(
          {int? id, String? title, String? des, String? createTime, String? createTimeYMD, int? stopTime, String? notiTime, int? isMark, int? type, int? isMyDay, int? isFinish}) =>
      todo(
        id: id ?? this.id,
        title: title ?? this.title,
        des: des ?? this.des,
        createTime: createTime ?? this.createTime,
        createTimeYMD: createTimeYMD ?? this.createTimeYMD,
        stopTime: stopTime ?? this.stopTime,
        notiTime: notiTime ?? this.notiTime,
        isMark: isMark ?? this.isMark,
        type: type ?? this.type,
        isMyDay: isMyDay ?? this.isMyDay,
        isFinish: isFinish ?? this.isFinish,
      );
  @override
  String toString() {
    return (StringBuffer('todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('des: $des, ')
          ..write('createTime: $createTime, ')
          ..write('createTimeYMD: $createTimeYMD, ')
          ..write('stopTime: $stopTime, ')
          ..write('notiTime: $notiTime, ')
          ..write('isMark: $isMark, ')
          ..write('type: $type, ')
          ..write('isMyDay: $isMyDay, ')
          ..write('isFinish: $isFinish')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, des, createTime, createTimeYMD,
      stopTime, notiTime, isMark, type, isMyDay, isFinish);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.des == this.des &&
          other.createTime == this.createTime &&
          other.createTimeYMD == this.createTimeYMD &&
          other.stopTime == this.stopTime &&
          other.notiTime == this.notiTime &&
          other.isMark == this.isMark &&
          other.type == this.type &&
          other.isMyDay == this.isMyDay &&
          other.isFinish == this.isFinish);
}

class TodoTableCompanion extends UpdateCompanion<todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> des;
  final Value<String> createTime;
  final Value<String> createTimeYMD;
  final Value<int> stopTime;
  final Value<String> notiTime;
  final Value<int> isMark;
  final Value<int> type;
  final Value<int> isMyDay;
  final Value<int> isFinish;

  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.des = const Value.absent(),
    this.createTime = const Value.absent(),
    this.createTimeYMD = const Value.absent(),
    this.stopTime = const Value.absent(),
    this.notiTime = const Value.absent(),
    this.isMark = const Value.absent(),
    this.type = const Value.absent(),
    this.isMyDay = const Value.absent(),
    this.isFinish = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String des,
    required String createTime,
    required String createTimeYMD,
    required int stopTime,
    required String notiTime,
    required int isMark,
    required int type,
    required int isMyDay,
    required int isFinish,
  })  : title = Value(title),
        des = Value(des),
        createTime = Value(createTime),
        createTimeYMD = Value(createTimeYMD),
        stopTime = Value(stopTime),
        notiTime = Value(notiTime),
        isMark = Value(isMark),
        type = Value(type),
        isMyDay = Value(isMyDay),
        isFinish = Value(isFinish);
  static Insertable<todo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? des,
    Expression<String>? createTime,
    Expression<String>? createTimeYMD,
    Expression<int>? stopTime,
    Expression<String>? notiTime,
    Expression<int>? isMark,
    Expression<int>? type,
    Expression<int>? isMyDay,
    Expression<int>? isFinish,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (des != null) 'des': des,
      if (createTime != null) 'create_time': createTime,
      if (createTimeYMD != null) 'create_time_y_m_d': createTimeYMD,
      if (stopTime != null) 'stop_time': stopTime,
      if (notiTime != null) 'noti_time': notiTime,
      if (isMark != null) 'is_mark': isMark,
      if (type != null) 'type': type,
      if (isMyDay != null) 'is_my_day': isMyDay,
      if (isFinish != null) 'is_finish': isFinish,
    });
  }

  TodoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? des,
      Value<String>? createTime,
      Value<String>? createTimeYMD,
      Value<int>? stopTime,
      Value<String>? notiTime,
      Value<int>? isMark,
      Value<int>? type,
      Value<int>? isMyDay,
      Value<int>? isFinish}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      des: des ?? this.des,
      createTime: createTime ?? this.createTime,
      createTimeYMD: createTimeYMD ?? this.createTimeYMD,
      stopTime: stopTime ?? this.stopTime,
      notiTime: notiTime ?? this.notiTime,
      isMark: isMark ?? this.isMark,
      type: type ?? this.type,
      isMyDay: isMyDay ?? this.isMyDay,
      isFinish: isFinish ?? this.isFinish,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (des.present) {
      map['des'] = Variable<String>(des.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (createTimeYMD.present) {
      map['create_time_y_m_d'] = Variable<String>(createTimeYMD.value);
    }
    if (stopTime.present) {
      map['stop_time'] = Variable<int>(stopTime.value);
    }
    if (notiTime.present) {
      map['noti_time'] = Variable<String>(notiTime.value);
    }
    if (isMark.present) {
      map['is_mark'] = Variable<int>(isMark.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (isMyDay.present) {
      map['is_my_day'] = Variable<int>(isMyDay.value);
    }
    if (isFinish.present) {
      map['is_finish'] = Variable<int>(isFinish.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('des: $des, ')
          ..write('createTime: $createTime, ')
          ..write('createTimeYMD: $createTimeYMD, ')
          ..write('stopTime: $stopTime, ')
          ..write('notiTime: $notiTime, ')
          ..write('isMark: $isMark, ')
          ..write('type: $type, ')
          ..write('isMyDay: $isMyDay, ')
          ..write('isFinish: $isFinish')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable with TableInfo<$TodoTableTable, todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _desMeta = const VerificationMeta('des');
  @override
  late final GeneratedColumn<String?> des = GeneratedColumn<String?>(
      'des', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createTimeMeta = const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<String?> createTime = GeneratedColumn<String?>(
      'create_time', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createTimeYMDMeta = const VerificationMeta('createTimeYMD');
  @override
  late final GeneratedColumn<String?> createTimeYMD = GeneratedColumn<String?>('create_time_y_m_d', aliasedName, false, type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _stopTimeMeta = const VerificationMeta('stopTime');
  @override
  late final GeneratedColumn<int?> stopTime = GeneratedColumn<int?>('stop_time', aliasedName, false, type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _notiTimeMeta = const VerificationMeta('notiTime');
  @override
  late final GeneratedColumn<String?> notiTime = GeneratedColumn<String?>('noti_time', aliasedName, false, type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isMarkMeta = const VerificationMeta('isMark');
  @override
  late final GeneratedColumn<int?> isMark = GeneratedColumn<int?>('is_mark', aliasedName, false, type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isMyDayMeta = const VerificationMeta('isMyDay');
  @override
  late final GeneratedColumn<int?> isMyDay = GeneratedColumn<int?>(
      'is_my_day', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _isFinishMeta = const VerificationMeta('isFinish');
  @override
  late final GeneratedColumn<int?> isFinish = GeneratedColumn<int?>(
      'is_finish', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        des,
        createTime,
        createTimeYMD,
        stopTime,
        notiTime,
        isMark,
        type,
        isMyDay,
        isFinish
      ];
  @override
  String get aliasedName => _alias ?? 'todo_table';
  @override
  String get actualTableName => 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('des')) {
      context.handle(
          _desMeta, des.isAcceptableOrUnknown(data['des']!, _desMeta));
    } else if (isInserting) {
      context.missing(_desMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('create_time_y_m_d')) {
      context.handle(
          _createTimeYMDMeta,
          createTimeYMD.isAcceptableOrUnknown(
              data['create_time_y_m_d']!, _createTimeYMDMeta));
    } else if (isInserting) {
      context.missing(_createTimeYMDMeta);
    }
    if (data.containsKey('stop_time')) {
      context.handle(_stopTimeMeta,
          stopTime.isAcceptableOrUnknown(data['stop_time']!, _stopTimeMeta));
    } else if (isInserting) {
      context.missing(_stopTimeMeta);
    }
    if (data.containsKey('noti_time')) {
      context.handle(_notiTimeMeta,
          notiTime.isAcceptableOrUnknown(data['noti_time']!, _notiTimeMeta));
    } else if (isInserting) {
      context.missing(_notiTimeMeta);
    }
    if (data.containsKey('is_mark')) {
      context.handle(_isMarkMeta,
          isMark.isAcceptableOrUnknown(data['is_mark']!, _isMarkMeta));
    } else if (isInserting) {
      context.missing(_isMarkMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_my_day')) {
      context.handle(_isMyDayMeta,
          isMyDay.isAcceptableOrUnknown(data['is_my_day']!, _isMyDayMeta));
    } else if (isInserting) {
      context.missing(_isMyDayMeta);
    }
    if (data.containsKey('is_finish')) {
      context.handle(_isFinishMeta,
          isFinish.isAcceptableOrUnknown(data['is_finish']!, _isFinishMeta));
    } else if (isInserting) {
      context.missing(_isFinishMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return todo.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }
}

class todolist extends DataClass implements Insertable<todolist> {
  final int id;
  final String title;
  final String des;
  final String createTime;
  final String bgColor;
  final int sortType;
  final int type;
  final int count;
  todolist(
      {required this.id,
      required this.title,
      required this.des,
      required this.createTime,
      required this.bgColor,
      required this.sortType,
      required this.type,
      required this.count});
  factory todolist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return todolist(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      des: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}des'])!,
      createTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_time'])!,
      bgColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bg_color'])!,
      sortType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sort_type'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['des'] = Variable<String>(des);
    map['create_time'] = Variable<String>(createTime);
    map['bg_color'] = Variable<String>(bgColor);
    map['sort_type'] = Variable<int>(sortType);
    map['type'] = Variable<int>(type);
    map['count'] = Variable<int>(count);
    return map;
  }

  TodoListTableCompanion toCompanion(bool nullToAbsent) {
    return TodoListTableCompanion(
      id: Value(id),
      title: Value(title),
      des: Value(des),
      createTime: Value(createTime),
      bgColor: Value(bgColor),
      sortType: Value(sortType),
      type: Value(type),
      count: Value(count),
    );
  }

  factory todolist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return todolist(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      des: serializer.fromJson<String>(json['des']),
      createTime: serializer.fromJson<String>(json['createTime']),
      bgColor: serializer.fromJson<String>(json['bgColor']),
      sortType: serializer.fromJson<int>(json['sortType']),
      type: serializer.fromJson<int>(json['type']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'des': serializer.toJson<String>(des),
      'createTime': serializer.toJson<String>(createTime),
      'bgColor': serializer.toJson<String>(bgColor),
      'sortType': serializer.toJson<int>(sortType),
      'type': serializer.toJson<int>(type),
      'count': serializer.toJson<int>(count),
    };
  }

  todolist copyWith(
          {int? id,
          String? title,
          String? des,
          String? createTime,
          String? bgColor,
          int? sortType,
          int? type,
          int? count}) =>
      todolist(
        id: id ?? this.id,
        title: title ?? this.title,
        des: des ?? this.des,
        createTime: createTime ?? this.createTime,
        bgColor: bgColor ?? this.bgColor,
        sortType: sortType ?? this.sortType,
        type: type ?? this.type,
        count: count ?? this.count,
      );
  @override
  String toString() {
    return (StringBuffer('todolist(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('des: $des, ')
          ..write('createTime: $createTime, ')
          ..write('bgColor: $bgColor, ')
          ..write('sortType: $sortType, ')
          ..write('type: $type, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, des, createTime, bgColor, sortType, type, count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is todolist &&
          other.id == this.id &&
          other.title == this.title &&
          other.des == this.des &&
          other.createTime == this.createTime &&
          other.bgColor == this.bgColor &&
          other.sortType == this.sortType &&
          other.type == this.type &&
          other.count == this.count);
}

class TodoListTableCompanion extends UpdateCompanion<todolist> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> des;
  final Value<String> createTime;
  final Value<String> bgColor;
  final Value<int> sortType;
  final Value<int> type;
  final Value<int> count;
  const TodoListTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.des = const Value.absent(),
    this.createTime = const Value.absent(),
    this.bgColor = const Value.absent(),
    this.sortType = const Value.absent(),
    this.type = const Value.absent(),
    this.count = const Value.absent(),
  });
  TodoListTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String des,
    required String createTime,
    required String bgColor,
    required int sortType,
    required int type,
    required int count,
  })  : title = Value(title),
        des = Value(des),
        createTime = Value(createTime),
        bgColor = Value(bgColor),
        sortType = Value(sortType),
        type = Value(type),
        count = Value(count);
  static Insertable<todolist> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? des,
    Expression<String>? createTime,
    Expression<String>? bgColor,
    Expression<int>? sortType,
    Expression<int>? type,
    Expression<int>? count,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (des != null) 'des': des,
      if (createTime != null) 'create_time': createTime,
      if (bgColor != null) 'bg_color': bgColor,
      if (sortType != null) 'sort_type': sortType,
      if (type != null) 'type': type,
      if (count != null) 'count': count,
    });
  }

  TodoListTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? des,
      Value<String>? createTime,
      Value<String>? bgColor,
      Value<int>? sortType,
      Value<int>? type,
      Value<int>? count}) {
    return TodoListTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      des: des ?? this.des,
      createTime: createTime ?? this.createTime,
      bgColor: bgColor ?? this.bgColor,
      sortType: sortType ?? this.sortType,
      type: type ?? this.type,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (des.present) {
      map['des'] = Variable<String>(des.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (bgColor.present) {
      map['bg_color'] = Variable<String>(bgColor.value);
    }
    if (sortType.present) {
      map['sort_type'] = Variable<int>(sortType.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoListTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('des: $des, ')
          ..write('createTime: $createTime, ')
          ..write('bgColor: $bgColor, ')
          ..write('sortType: $sortType, ')
          ..write('type: $type, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $TodoListTableTable extends TodoListTable
    with TableInfo<$TodoListTableTable, todolist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoListTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _desMeta = const VerificationMeta('des');
  @override
  late final GeneratedColumn<String?> des = GeneratedColumn<String?>(
      'des', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createTimeMeta = const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<String?> createTime = GeneratedColumn<String?>(
      'create_time', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _bgColorMeta = const VerificationMeta('bgColor');
  @override
  late final GeneratedColumn<String?> bgColor = GeneratedColumn<String?>(
      'bg_color', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sortTypeMeta = const VerificationMeta('sortType');
  @override
  late final GeneratedColumn<int?> sortType = GeneratedColumn<int?>(
      'sort_type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int?> count = GeneratedColumn<int?>(
      'count', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, des, createTime, bgColor, sortType, type, count];
  @override
  String get aliasedName => _alias ?? 'todo_list_table';
  @override
  String get actualTableName => 'todo_list_table';
  @override
  VerificationContext validateIntegrity(Insertable<todolist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('des')) {
      context.handle(
          _desMeta, des.isAcceptableOrUnknown(data['des']!, _desMeta));
    } else if (isInserting) {
      context.missing(_desMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('bg_color')) {
      context.handle(_bgColorMeta,
          bgColor.isAcceptableOrUnknown(data['bg_color']!, _bgColorMeta));
    } else if (isInserting) {
      context.missing(_bgColorMeta);
    }
    if (data.containsKey('sort_type')) {
      context.handle(_sortTypeMeta,
          sortType.isAcceptableOrUnknown(data['sort_type']!, _sortTypeMeta));
    } else if (isInserting) {
      context.missing(_sortTypeMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  todolist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return todolist.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoListTableTable createAlias(String alias) {
    return $TodoListTableTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final $TodoListTableTable todoListTable = $TodoListTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [todoTable, todoListTable];
}
