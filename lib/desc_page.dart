import 'package:flutter/material.dart';

class DescClass extends StatelessWidget{
  String mDesc ="";
  DescClass({required String this.mDesc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Description")),
      ),
      body: Padding(
        padding:  EdgeInsets.all(30),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:  EdgeInsets.all(15),
            child: Text(mDesc,textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 20)),
          ),
        ),
      ),
    );
  }

}