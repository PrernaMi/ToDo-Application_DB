import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../data/local/db_helper.dart';
import '../data/local/db_list.dart';
import '../desc_page.dart';

class NavHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NavHomePage();
}

class _NavHomePage extends State<NavHomePage>{
  int isCompleted = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DbHelper? myDb;
  double progress =0;
  Icon icon = Icon(Icons.circle_outlined,size: 30,);
  @override
  void initState() {
    myDb = DbHelper.getInstances;
    getAllNotes();
    super.initState();
  }

  Future<void> getAllNotes()async{
    var db = myDb!;
    DbList.allTask =await db.getFromDb();
    progress = await db.getIsCompletedCount();
    progress == 0? progress = 0: progress = (progress/DbList.allTask.length*100).roundToDouble();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue,Colors.blue.shade200]
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
              height: 200,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                          child: Text("Today's progress summery",style: TextStyle(color: Colors.white,fontSize: 23),)),
                      /*-------Task Added-------*/
                      Expanded(
                        flex: 1,
                          child: Text("${DbList.allTask.length} Tasks",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      SizedBox(height: 25,),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text("Progress",style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 50,),
                                      Text("${progress}%",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 140,
                                        decoration: BoxDecoration(
                                            border: Border(top: BorderSide(color: Colors.grey.shade400,width: 7)),
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                      ),
                                      Container(
                                        width: 140*progress/100,
                                        decoration: BoxDecoration(
                                            border: Border(top: BorderSide(color: Colors.white70,width: 7)),
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            /*------------------Images------------*/
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  ClipOval(child: Image.asset("assets/images/img.png",height: 40,width: 40,)),
                                  Positioned(
                                      left: 20,
                                      child: ClipOval(child: Image.asset("assets/images/img_1.png",height: 40,width: 40,))),
                                  Positioned(
                                      left: 40,
                                      child: ClipOval(child: Image.asset("assets/images/img_2.png",height: 40,width: 40,))) ,
                                  Positioned(
                                      left: 60,
                                      child: ClipOval(child: Image.asset("assets/images/img_3.png",height: 40,width: 40,)))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's task",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                Text("See all",style: TextStyle(color: Colors.grey.shade400,fontSize: 15),),
              ],
            ),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics,
                  itemCount: DbList.allTask.length,
                  itemBuilder: (_,Index){
                    return DbList.allTask.isNotEmpty ? Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DescClass(mDesc: DbList.allTask[Index].desc,);
                            }));
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 1),
                            /*--------Leading--------*/
                            leading: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  InkWell(
                                      splashColor: Colors.transparent,
                                      onTap:(){
                                        if(DbList.allTask[Index].isCompleted == 0){
                                          isCompleted = 1;
                                        }else{
                                          isCompleted = 0;
                                        }
                                        updateIsCompleted(s_no :DbList.allTask[Index].s_no!,isCompleted: isCompleted);
                                      },
                                      child: DbList.allTask[Index].isCompleted==0?icon:Icon(Icons.check_circle,color: Colors.blueAccent,size: 30,),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade400,
                                      ),
                                      child: Center(child: Text('${DbList.allTask[Index].s_no!}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),))),
                                ],
                              ),
                            ),
                            /*--------Title--------*/
                            title: (DbList.allTask[Index].isCompleted == null || DbList.allTask[Index].isCompleted == 0)?Text(DbList.allTask[Index].title,style: TextStyle(fontWeight: FontWeight.bold,),):Text(DbList.allTask[Index].title,style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),

                            /*--------SubTitle--------*/
                            subtitle: Row(
                              children: [
                                Text(DbList.allTask[Index].date),
                                SizedBox(width: 5,),
                                Text(DbList.allTask[Index].time),
                              ],
                            ),

                            /*--------Trailing--------*/
                            trailing: InkWell(
                                onTap: (){
                                  titleController.text = DbList.allTask[Index].title;
                                  descController.text = DbList.allTask[Index].desc;
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context, builder: (_){
                                    return Padding(
                                      padding:  EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Update Task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                                          SizedBox(height: 50,),

                                          /*-------Title-------------------*/
                                          TextField(
                                            keyboardType: TextInputType.text,
                                            controller: titleController,
                                            decoration: InputDecoration(
                                                labelText: "Title",
                                                icon: Icon(Icons.notes),
                                                hintText: "Enter your title...",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                )
                                            ),
                                          ),
                                          /*-------Desc-------------------*/
                                          TextField(
                                            maxLines: 3,
                                            controller: descController,
                                            decoration: InputDecoration(
                                                icon: Icon(Icons.description),
                                                labelText: "Description",
                                                hintText: "Enter your Description...",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                )
                                            ),
                                          ),
                                          /*-------Date-------------------*/
                                          TextField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                                labelText: "Date",
                                                hintText: "Enter your date..",
                                                icon:Icon(Icons.date_range),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                )
                                            ),
                                          ),
                                          /*-------Time-------------------*/
                                          TextField(
                                            controller: timeController,
                                            decoration: InputDecoration(
                                                labelText: "Time",
                                                hintText: "Enter your Time..",
                                                icon:Icon(Icons.access_time),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                )
                                            ),
                                          ),
                                          /*-----------Buttons-----------*/
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                /*-----------Update-----------*/
                                                OutlinedButton(onPressed: (){
                                                  updateTask(s_no: DbList.allTask[Index].s_no!);
                                                  Navigator.pop(context);
                                                }, child: Text("Update")),
                                                /*-----------Cancel-----------*/
                                                OutlinedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text("Cancel")),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                },
                                child: Icon(Icons.edit,color: Colors.blue,size: 30,)),
                            tileColor: Colors.grey.shade200,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                      ],
                    ): Center(child: Text("No task added",style: TextStyle(color: Colors.black),));
                  }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: "Add task",
        onPressed: (){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context, builder: (context){
            return SizedBox(
              height: double.infinity,
              child: Padding(
                padding:  EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(child: Text("Add your task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                    /*-------Title-------------------*/
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: "Title",
                          icon: Icon(Icons.notes),
                          hintText: "Enter your title...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                    /*-------Desc-------------------*/
                    TextField(
                      maxLines: 3,
                      controller: descController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.description),
                          labelText: "Description",
                          hintText: "Enter your Description...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                    /*-------Date-------------------*/
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          labelText: "Date",
                          hintText: "Enter your date..",
                          icon:Icon(Icons.date_range),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                    /*-------Time-------------------*/
                    TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                          labelText: "Time",
                          hintText: "Enter your Time..",
                          icon:Icon(Icons.access_time),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                    /*-------Buttons-------------------*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: (){
                              addOneTask();
                              myDb!.deleteTask(isCompleted: 0, s_no: DbList.allTask.length+1);
                              titleController.clear();
                              descController.clear();
                              timeController.clear();
                              dateController.clear();
                              Navigator.pop(context);
                            }, child: Text("Add")),
                        OutlinedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Cancel")),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        },
        child: Icon(Icons.add,size: 30,color: Colors.white,),
      ),
    );

  }
  void addOneTask()async{
    String mTitle = titleController.text.toString();
    String mDesc = descController.text.toString();
    String mDate = dateController.text.toString();
    String mTime = timeController.text.toString();
    String msg = "Task added successfully";
    bool check = await myDb!.addTodo(title: mTitle, desc: mDesc, date: mDate, time: mTime,isCom: 0);
    getAllNotes();
    if(!check){
      msg = "Task added failed";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void updateIsCompleted({required int s_no,required int isCompleted})async{
    var db = myDb;
    String msg = "Task completed";
    db!.addIsCompleted(isCompleted: isCompleted, s_no: s_no);
    getAllNotes();
    if(isCompleted == 0){
      msg = "Task pending..";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void updateTask({required int s_no})async{
    String mTitle = titleController.text.toString();
    String mDesc = descController.text.toString();
    String mDate = dateController.text.toString();
    String mTime = timeController.text.toString();
    var db = myDb;
    String msg = "Task Updated";
    bool check = await db!.update(s_no: s_no, title: mTitle, desc: mDesc, date: mDate, time: mTime);
    getAllNotes();
    print(DbList.allTask);
    if(!check){
      msg = "Task Updated failed..";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}