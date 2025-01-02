import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  // Cargar las tareas desde SharedPreferences
  Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('tasks') ?? [];
  }

  // Guardar una nueva tarea en SharedPreferences
  Future<void> saveTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    tasks.add(task);
    await prefs.setStringList('tasks', tasks);
  }

  // Eliminar una tarea
  Future<void> removeTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    tasks.remove(task);
    await prefs.setStringList('tasks', tasks);
  }
}
