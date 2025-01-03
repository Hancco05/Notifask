import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import '../models/task_model.dart';

class PendingTasksScreen extends StatelessWidget {
  final DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tareas Pendientes')),
      body: FutureBuilder<List<Task>>(
        future: _dbHelper.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final pendingTasks =
              snapshot.data!.where((task) => task.isPending).toList();
          return ListView.builder(
            itemCount: pendingTasks.length,
            itemBuilder: (context, index) {
              final task = pendingTasks[index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text(task.date),
              );
            },
          );
        },
      ),
    );
  }
}
