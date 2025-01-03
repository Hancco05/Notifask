import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import '../models/task_model.dart';

class TaskListScreen extends StatelessWidget {
  final DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: FutureBuilder<List<Task>>(
        future: _dbHelper.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text(task.date),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _dbHelper.deleteTask(task.id!);
                    (context as Element).markNeedsBuild();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
