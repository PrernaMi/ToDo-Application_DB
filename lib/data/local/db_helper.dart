import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../notes_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstances = DbHelper._();
  static final String tableToDo = "todoTable";
  static final String tableColTitle = "title";
  static final String tableColSno = "s_no";
  static final String tableColDesc = "desc";
  static final String tableColIsCompleted = "isCompleted";
  static final String tableColTime = "time";
  static final String tableColDate = "date";

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory myDirectory = await getApplicationDocumentsDirectory();

    String rootPath = myDirectory.path;

    String dbPath = join(rootPath, "todo.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.rawQuery('''create table $tableToDo ( 
              $tableColSno Integer primary key autoincrement, 
              $tableColTitle text, 
              $tableColDesc text, 
              $tableColDate text,
              $tableColTime text,
              $tableColIsCompleted Integer 
              )''');
    });
  }

  //insert
  Future<bool> addTodo(
      {required String title,
      required String desc,
      required String date,
      required String time,
      required int isCom}) async {
    var db = await getDb();
    int count = await db.insert(
        tableToDo,
        NotesModel(
                title: title,
                desc: desc,
                time: time,
                date: date,
                isCompleted: isCom)
            .toMap());
    return count > 0;
  }

  //update
  Future<bool> update({required int s_no, required String title, required String desc, required String date, required String time}) async {
    var db = await getDb();
    int count = await db.update(
        tableToDo,
        NotesModel(
                title: title,
                desc: desc,
                time: time,
                date: date,).toMap(),
        where: '$tableColSno = ?',
        whereArgs: ['$s_no']);
    return count > 0;
  }

  //get All things
  Future<List<NotesModel>> getFromDb() async {
    var db = await getDb();
    List<NotesModel> mList =[];
    var allNotes = await db.query(tableToDo);
    for(Map<String,dynamic> eachNote in allNotes){
      NotesModel eachModel = NotesModel.fromMap(eachNote);
      mList.add(eachModel);
    }
    return mList;
  }

  //delete
  Future<bool> deleteTask({required int isCompleted, required int s_no}) async {
    var db = await getDb();
    int count = await db.update(tableToDo, {tableColIsCompleted: isCompleted},
        where: '$tableColSno = ?', whereArgs: ['$s_no']);
    return count > 0;
  }

  //get is completed
  Future<double> getIsCompletedCount() async {
    var db = myDb;
    var c = await db!.rawQuery(
        'SELECT COUNT(*) as count FROM $tableToDo WHERE $tableColIsCompleted = ?',
        [1]);
    int count = Sqflite.firstIntValue(c) ?? 0;
    return count.toDouble();
  }

  //set updated isCompleted value in DB
  Future<bool> addIsCompleted(
      {required int isCompleted, required int s_no}) async {
    var db = myDb;
    int count = await db!.update(
        tableToDo,
        {
          tableColIsCompleted: isCompleted,
        },
        where: '$tableColSno = $s_no');
    return count > 0;
  }
}
