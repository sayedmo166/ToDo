import 'package:flutter/material.dart';
import 'package:todo/tabs/settings/Settings_tab.dart';
import 'package:todo/tabs/tasks/Tasks_tab.dart';
import 'package:todo/tabs/tasks/add_task_buttom_sheet.dart';
class HomeScreen extends StatefulWidget {
  static const String routname = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedindex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => TaskBottomSheet(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.transparent,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            currentIndex: selectedindex,
            onTap: (value) {
              selectedindex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ]),
      ),
    );
  }
}