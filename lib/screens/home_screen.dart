import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Al hacer logout, redirige al login
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Acción para crear tarea
              },
              child: Text('Create Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para ver tarea
              },
              child: Text('View Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para eliminar tarea
              },
              child: Text('Delete Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para ver calendario
              },
              child: Text('Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
