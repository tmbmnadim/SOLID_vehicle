import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

abstract class IDatabaseManager<R> {
  Future<void> initDatabase();
  Future<void> openDatabase();
  Future<List<R>> getData();
  Future<R?> getDataByID(int id);
  Future<R?> saveData(R data);
  Future<void> closeDatabase();
  Future<void> deleteDatabase();
}

abstract class IVehicleDatabaseManager<T> implements IDatabaseManager<T> {
  sqflite.Database? database;
  final String _databaseName = 'vehicles.db';
  String _databasePath = '';
  abstract String tableName;
  @override
  Future<void> initDatabase() async {
    var databasesPath = await sqflite.getDatabasesPath();
    _databasePath = '$databasesPath/$_databaseName';

    // Make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {
      debugPrint("Couldn't create directory");
    }

    openDatabase();
  }

  @override
  Future<void> openDatabase() async {
    try {
      database = await sqflite.openDatabase(
        _databasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE hood (
_id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
description TEXT NOT NULL,
topLength REAL NOT NULL,
bottomLength REAL NOT NULL,
height REAL NOT NULL,
position REAL NOT NULL
)''');

          await db.execute(
            '''CREATE TABLE body (
_id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
description TEXT NOT NULL,
length REAL NOT NULL,
height REAL NOT NULL
)''',
          );

          await db.execute(
            '''CREATE TABLE wheels (
_id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
description TEXT NOT NULL,
horizontalPosition REAL NOT NULL,
verticalPosition REAL NOT NULL,
radius REAL NOT NULL,
tireRimRatio REAL NOT NULL
)''',
          );

          await db.execute('''CREATE TABLE vehicle (
_id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
price REAL NOT NULL,
hood INTEGER,
body INTEGER,
frontWheel INTEGER,
backWheel INTEGER,
FOREIGN KEY (hood) REFERENCES hood(_id),
FOREIGN KEY (body) REFERENCES body(_id),
FOREIGN KEY (frontWheel) REFERENCES wheels(_id),
FOREIGN KEY (backWheel) REFERENCES wheels(_id)
)''');
        },
      );
    } catch (e) {
      debugPrint(
        "openDatabase<VehicleDatabaseManager> Couldn't open database",
      );
    }
  }

  @override
  Future<List<T>> getData();
  @override
  Future<T?> getDataByID(int id);
  @override
  Future<T?> saveData(T data);

  @override
  Future<void> closeDatabase() async {
    try {
      await database!.close();
    } catch (e) {
      debugPrint(
        "closeDatabase<VehicleDatabaseManager> Couldn't close database",
      );
    }
  }

  @override
  Future<void> deleteDatabase() async {
    sqflite.deleteDatabase(_databasePath);
  }
}
