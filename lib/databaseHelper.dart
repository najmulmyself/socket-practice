import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
      print("database not null");
      return _database!;
    }
    print("database null");
    _database = await initializeDatabase();
    return _database!;
  }

  Future<void> requestStoragePermission() async {}

  Future<Database> initializeDatabase() async {
    final storageDirectory = await getTemporaryDirectory();

    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, you can now write to external storage.
      String databasePath = await getDatabasesPath();
      print(" after path printing");
      String customFolderPath = '/storage/emulated/0/DB';
      Directory customDirectory = Directory(customFolderPath);
      // await customDirectory.create(recursive: true);
      // File customFile = File(customFolderPath);
      String path = join(customDirectory.path, dbName);
      print("if init works ${customDirectory.path}");
      print(path);

      // Future<String> getExternalStorageDirectoryFunc() async {
      //   return (await getExternalStorageDirectory())!.path;
      // }
    } else {
      // Permission denied.
      print("permission denied");
    }

    return database;
  }

  Future<int> insertData(MyData data) async {
    final db = await database;
    int id = await db.insert(table, data.toMap());
    return id;
  }

  Future<List<MyData>> getAllData() async {
    final db = await database;
    print(
      await getDatabasesPath(),
    );
    // Future<String> getExternalStorageDirectoryFunc() async {
    //   return (await getExternalStorageDirectory())!.path;
    // }

    // final storageDirectory = await getExternalStorageDirectory();
    // final file = File('$storageDirectory/my_file.txt');

    // print(file);
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
