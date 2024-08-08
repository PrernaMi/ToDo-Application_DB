import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_database/nav_pages/nav_home_screen.dart';
import 'nav_pages/setting.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> navPages = [
    NavHomePage(),
    SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle,size: 30,),
        centerTitle: true,
        title: Text("Homepage",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.notifications,size: 30,),
          SizedBox(width: 10,)
        ],
      ),
      body: navPages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value){
          selectedIndex = value;
          setState(() {

          });
        },
        indicatorColor: Colors.blue,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home,color: Colors.white,),
              icon: Icon(Icons.home_outlined),
              label: "Home",),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings,color: Colors.white,),
            icon: Icon(Icons.settings_outlined),
            label: "Settings",),
        ],
      ),
    );
  }

}