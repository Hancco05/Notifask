import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  Database? _database;

  AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT)',
        );

        // Inserta un usuario administrador predeterminado
        await db.insert(
          'users',
          {'username': 'admin', 'password': 'admin123'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  Future<bool> register(String username, String password) async {
    try {
      final result = await _database?.insert(
        'users',
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return result != null;
    } catch (e) {
      return false; // Usuario ya existe
    }
  }

  Future<bool> login(String username, String password) async {
    final result = await _database?.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    // Revisa si el resultado no está vacío
    return result != null && result.isNotEmpty;
  }
}
