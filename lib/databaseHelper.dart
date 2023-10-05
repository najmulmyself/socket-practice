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
    // requestStoragePermission();
    return _database!;
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, continue with your code.
    } else if (status.isDenied) {
      // Permission denied.
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings.
      openAppSettings();
    }
  }

  // Future<Database> initializeDatabase() async {
  //   final storageDirectory = await getTemporaryDirectory();

  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     // Permission granted, you can now write to external storage.
  //     String databasePath = await getDatabasesPath();
  //     print(" after path printing");
  //     String customFolderPath = '/storage/emulated/0/DB';
  //     Directory customDirectory = Directory(customFolderPath);
  //     // await customDirectory.create(recursive: true);
  //     // File customFile = File(customFolderPath);
  //     String path = join(customDirectory.path, dbName);
  //     print("if init works ${customDirectory.path}");
  //     print(path);

  //     Database database = await openDatabase(
  //       path,
  //       version: 1,
  //       onCreate: (db, version) {
  //         db.execute(
  //             'CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, age INTEGER)');
  //       },
  //     );
  //     return database;

  //     // Future<String> getExternalStorageDirectoryFunc() async {
  //     //   return (await getExternalStorageDirectory())!.path;
  //     // }
  //   } else {
  //     // Permission denied.
  //     print("permission denied");
  //   }

  //   return database;
  // }

  /////////////////////////////////////////////
  Future<bool> initDatabase() async {
    Directory ? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$dbName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
            Database database = await openDatabase(
        saveFile.path,
        version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, age INTEGER)');
        },
      );
      return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }


    Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  /////////////////////////////////////////////

  Future<Database> initializeDatabase() async {
    final storageDirectory = await getApplicationDocumentsDirectory();

    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, you can now write to external storage.
      String databasePath = await getDatabasesPath();
      print(" after path printing");
      String customFolderPath = '${storageDirectory.path}/DB';
      Directory customDirectory = Directory(customFolderPath);
      if (!customDirectory.existsSync()) {
        customDirectory.createSync(recursive: true);
      }
      String path = join(customDirectory.path, dbName);
      print("if init works ${customDirectory.path}");
      print(path);

      // Open the database
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, age INTEGER)');
        },
      );

      return database; // Return the database instance
    } else {
      // Permission denied.
      print("Permission denied");
      return database; // Return null to indicate a failure to open the database
    }
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
