import 'package:todo_database/data/local/db_helper.dart';
import 'package:todo_database/data/local/db_list.dart';

class NotesModel{
  String title;
  int? s_no;
  String desc;
  String time;
  String date;
  int? isCompleted;

  NotesModel({
    this.s_no,
    required this.title,
    required this.desc,
    required this.time,
    required this.date,
    this.isCompleted
  });

  //toModel
  factory NotesModel.fromMap(Map<String,dynamic>map){
    return NotesModel(
        s_no: map[DbHelper.tableColSno],
        title: map[DbHelper.tableColTitle],
        desc: map[DbHelper.tableColDesc],
        time: map[DbHelper.tableColTime],
        date: map[DbHelper.tableColDate],
        isCompleted: map[DbHelper.tableColIsCompleted]
    );
  }

  //toMap
  Map<String,dynamic> toMap(){
    return {
      DbHelper.tableColTitle: title,
      DbHelper.tableColDesc : desc,
      DbHelper.tableColDate : date,
      DbHelper.tableColTime : time,
    };
  }

}