import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';
// import 'package:path/path.dart';

class DatabaseHelper {
  static const table = 'userTable';
  static Database?
      _database; // what is another way to write abstact class - static Database  _database = Database() ??
  static String dbName = 'my_database.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    print(" after path printing");
    String path = join(databasePath, dbName);
    print(path);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, age INTEGER)');
      },
    );
    return database;
  }

  Future<int> insertData(MyData data) async {
    final db = await database;
    int id = await db.insert(table, data.toMap());
    return id;
  }

  Future<List<MyData>> getAllData() async {
    final db = await database;
    print(await getDatabasesPath());
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return MyData.fromMap(maps[i]);
    });
  }

  Future closeDatabase() async {
    final db = await database;
    db.close();
  }
}
