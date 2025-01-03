import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/pending_tasks_screen.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/add_task': (context) => AddTaskScreen(),
        '/task_list': (context) => TaskListScreen(),
        '/pending_tasks': (context) => PendingTasksScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}
