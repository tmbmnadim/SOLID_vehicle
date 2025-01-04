import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/vehicles/vehicle_entity.dart';

class VehicleDatabaseManager {
  VehicleDatabaseManager._();

  static VehicleDatabaseManager instance = VehicleDatabaseManager._();

  factory VehicleDatabaseManager() => instance;

  static Database? database;

  static const String _databaseName = "vehicle.db";

  static String _databasePath = "";

  static void initVehicleDatabase() async {
    var databasesPath = await getDatabasesPath();
    _databasePath = '$databasesPath/$_databaseName';

    // Make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {
      debugPrint("Couldn't create directory");
    }

    database = await openDatabase(
      _databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE vehicle (
            _id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            price INTEGER NOT NULL,
            hood INTEGER FOREIGN KEY,
            body INTEGER FOREIGN KEY,
            frontWheels INTEGER FOREIGN KEY,
            backWheels INTEGER FOREIGN KEY,
          )
          ''',
        );

        db.execute(
          '''
          CREATE TABLE hood (
            _id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            price INTEGER NOT NULL,
            hood TEXT NOT NULL
            body TEXT NOT NULL
            frontWheels TEXT NOT NULL
            backWheels TEXT NOT NULL
          )
          ''',
        );
      },
    );
  }

  static Future<void> insertVehicle(Vehicle vehicle) async {
    await database!.insert(
      'vehicle',
      vehicle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteVehicleDatabase() async {
    await deleteDatabase(_databasePath);
  }

  static Future<void> closeVehicleDatabase() async {
    await database!.close();
  }
}
