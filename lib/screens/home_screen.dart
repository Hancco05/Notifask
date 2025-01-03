import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'task_list_screen.dart';
import 'pending_tasks_screen.dart';
import 'calendar_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú Principal')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Agregar Tarea'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista de Tareas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskListScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.pending),
            title: Text('Tareas Pendientes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PendingTasksScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendario'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
