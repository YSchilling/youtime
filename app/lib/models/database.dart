import 'package:app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    database.execute("""CREATE TABLE todo(
          id INTEGER PRIMARY KEY,
          title TEXT,
          done INTEGER
          )""");
  }

  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'yourtime_database.db'),
      version: 1,
      onCreate: (db, version) {
        return createTables(db);
      },
    );
  }

  static Future<int> insertTodo(String title, bool done) async {
    final db = await getDB();

    final data = {'title': title, 'done': done};
    final id =
        db.insert('todo', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Todo>> getTodos() async {
    final db = await getDB();
    final List<Map<String, dynamic>> query =
        await db.query('todo', orderBy: 'id');

    return List.generate(query.length, (index) {
      return Todo(
        id: query[index]['id'],
        title: query[index]['title'],
        done: query[index]['done'] == 0 ? false : true,
      );
    });
  }

  static Future<Todo> getTodo(int id) async {
    final db = await getDB();
    final List<Map<String, dynamic>> query =
        await db.query('todo', where: 'id = ?', whereArgs: [id], limit: 1);

    return Todo(
        id: query[0]['id'], title: query[0]['title'], done: query[0]['done']);
  }

  static Future<int> updateTodo(Todo todo) async {
    final db = await getDB();

    final result = await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    return result;
  }

  static Future<void> deleteTodo(int id) async {
    final db = await getDB();
    try {
      await db.delete(
        'todo',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
