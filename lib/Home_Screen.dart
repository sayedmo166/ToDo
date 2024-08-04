import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/tabs/settings/Settings_tab.dart';
import 'package:todo/tabs/tasks/Tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;
  List<Widget> tabs =[
    TasksTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedTabIndex,
          onTap: (index){
        
            setState(() {
              selectedTabIndex =index;
        
            });
          },
          items: [BottomNavigationBarItem(

          label: 'Tasks',
        
          icon: Icon(Icons.list,size: 32,),),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings_outlined,size: 32,),),
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: Icon(Icons.add,
        size: 32,
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
