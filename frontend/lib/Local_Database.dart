// import 'dart:io';
// import 'dart:core';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBProvider {
//   DBProvider._();
//   static final DBProvider db = DBProvider._();
//   static Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database;
//     } else {
//       _database = await initDB();
//       return _database;
//     }
//   }
//
//   initDB() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, "RoboOfficialDB");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       db.execute("CREATE TABLE User("
//           "id INTEGER PRIMARY KEY,"
//           "first_name TEXT,"
//           "last_name TEXT,"
//           ")");
//     });
//   }
// }
