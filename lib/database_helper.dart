import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task.dart';

class DatabaseHelper {
  // Veritabanı adı ve versiyonu
  static const _databaseName = "TaskDatabase.db";
  static const _databaseVersion = 1;

  // Tablo adı ve sütun adları
  static const table = 'task_table';
  static const columnId = 'id';
  static const columnType = 'type';
  static const columnTitle = 'title';
  static String columnDueDate = 'dueDate';
  static const columnDescription = 'description';
  static const columnIsCompleted = 'is_completed';

  // Singleton sınıfı
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Tek bir app-wide veritabanı referansı
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Veritabanını açma (ve yoksa oluşturma)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Veritabanı tablosunu oluşturma SQL kodu
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnType TEXT NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnIsCompleted INTEGER NOT NULL
      )
    ''');
  }

  // Veri ekleme fonksiyonu
  Future<int> insert(Task task) async {
    Database db = await instance.database;
    return await db.insert(table, {
      columnId: task.id,
      columnType:
          task.type.toString().split('.').last, // Convert enum to string
      columnTitle: task.title,
      columnDescription: task.description,
      columnIsCompleted: task.isCompleted ? 1 : 0
    });
  }

  Future<List<Task>> queryAllRows() async {
    Database db = await instance.database;
    final result = await db.query(table);
    return result
        .map((json) => Task(
              id: json[columnId] as int, // Dönüştürme: Object? -> int
              type: TaskType.values.firstWhere((e) =>
                  e.toString().split('.').last == json[columnType] as String),
              title:
                  json[columnTitle] as String, // Dönüştürme: Object? -> String
              description: json[columnDescription]
                  as String, // Dönüştürme: Object? -> String
              dueDate: json[columnDueDate] != null
                  ? json[columnDueDate] as String
                  : "", // Dönüştürme: Object? -> String, null kontrolü eklendi
              isCompleted: (json[columnIsCompleted] as int) ==
                  1, // Dönüştürme: Object? -> int
            ))
        .toList();
  }

  // Veriyi güncelleme fonksiyonu
  Future<int> update(Task task) async {
    Database db = await instance.database;
    return await db.update(
        table,
        {
          columnType:
              task.type.toString().split('.').last, // Convert enum to string
          columnTitle: task.title,
          columnDescription: task.description,
          columnIsCompleted: task.isCompleted ? 1 : 0
        },
        where: '$columnId = ?',
        whereArgs: [task.id]);
  }

  // Veriyi silme fonksiyonu
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
