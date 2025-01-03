import 'package:flutter/material.dart';
import '../services/db_helper.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  String _importance = 'Baja'; // Valor predeterminado

  final DBHelper _dbHelper = DBHelper();

  Future<void> _addTask() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        name: _nameController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        importance: _importance,
      );
      await _dbHelper.insertTask(task);

      // Volver a la pantalla anterior con éxito
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre de la tarea'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    _dateController.text =
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha es obligatoria';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _importance,
                items: ['Baja', 'Media', 'Alta']
                    .map((importance) => DropdownMenuItem<String>(
                          value: importance,
                          child: Text(importance),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _importance = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Importancia'),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Agregar Tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
