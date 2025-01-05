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
            description TEXT NOT NULL,
            topLength REAL NOT NULL,
            bottomLength REAL NOT NULL,
            bottomLength REAL NOT NULL,
            height REAL NOT NULL,
            position REAL NOT NULL,
          )
          ''',
        );

        db.execute(
          '''
          CREATE TABLE body (
            _id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            length REAL NOT NULL,
            height REAL NOT NULL,
          )
          ''',
        );

        db.execute(
          '''
          CREATE TABLE wheels (
            _id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            horizontalPosition REAL NOT NULL,
            verticalPosition REAL NOT NULL,
            radius REAL NOT NULL,
            tireRimRatio REAL NOT NULL,
          )
          ''',
        );
      },
    );
  }

  static Future<int?> insertVehicle(Vehicle vehicle) async {
    try {
      // Insert front wheels and get the generated ID
      int frontWheelsId = await database!.insert(
        'wheels',
        vehicle.frontWheels.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert back wheels and get the generated ID
      int backWheelsId = await database!.insert(
        'wheels',
        vehicle.backWheels.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert hood and get the generated ID
      int hoodId = await database!.insert(
        'hood',
        vehicle.hood.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert body and get the generated ID
      int bodyId = await database!.insert(
        'body',
        vehicle.body.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert the vehicle using the generated IDs
      await database!.insert(
        'vehicle',
        {
          'id': vehicle.id,
          'name': vehicle.name,
          'price': vehicle.price,
          'hood': hoodId,
          'body': bodyId,
          'frontWheels': frontWheelsId,
          'backWheels': backWheelsId,
          'type': vehicle.runtimeType.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint(
        "insertVehicle<VehicleDatabaseManager> Couldn't insert vehicle",
      );
    }
    return null;
  }

  static Future<List<Vehicle>> getVehicles() async {
    List<Vehicle> vehicles = [];
    try {
      List<Map<String, Object?>> results = await database!.query('vehicle');
      for (Map<String, Object?> result in results) {
        vehicles.add(Vehicle.fromMap(result));
      }
    } catch (e) {
      debugPrint(
        "getVehicles<VehicleDatabaseManager> Couldn't get vehicles",
      );
    }
    return vehicles;
  }

  static Future<Vehicle> getVehicle(String id) async {}

  static Future<void> deleteVehicleDatabase() async {
    await deleteDatabase(_databasePath);
  }

  static Future<void> closeVehicleDatabase() async {
    await database!.close();
  }
}
