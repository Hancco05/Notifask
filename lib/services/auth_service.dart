import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
  }

  // Hash a password using SHA-256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Login method that checks if the username and password match
  Future<bool> login(String username, String password) async {
    final db = await database;

    // Hash the input password to compare with the stored hash
    String hashedPassword = _hashPassword(password);

    final res = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    return res.isNotEmpty;
  }

  // Register method that inserts a new user after checking if the user already exists
  Future<bool> register(String username, String password) async {
    final db = await database;

    // Check if the username already exists
    final existingUser = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (existingUser.isNotEmpty) {
      // User already exists, return false
      return false;
    }

    // Hash the password before saving it
    String hashedPassword = _hashPassword(password);

    try {
      // Insert the new user into the database
      final res = await db.insert(
        'users',
        {'username': username, 'password': hashedPassword},
      );
      return res > 0;
    } catch (e) {
      print("Error registering user: $e");
      return false;
    }
  }
}
