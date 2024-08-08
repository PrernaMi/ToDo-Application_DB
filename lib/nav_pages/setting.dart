import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _settingPage();
}

class _settingPage extends State<SettingPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Home",style: TextStyle(color: Colors.black,fontSize: 20),),
            Text("Logout",style: TextStyle(color: Colors.black,fontSize: 20),),
          ],
        ),
      ),
    );
  }

}