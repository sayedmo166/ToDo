import 'package:flutter/material.dart';
import 'package:todo/App_Theme.dart';
import 'package:todo/Home_Screen.dart';

void main() {
  runApp(ToDoApp());
}
class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName : (_)=> HomeScreen(),

      },
      theme:AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}

