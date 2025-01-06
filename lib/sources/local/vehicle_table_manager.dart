import 'package:flutter/foundation.dart';
import 'package:solid_principle/sources/local/database_manager.dart';

import '../../entities/vehicles/vehicle_entity.dart';

class VehicleTableManager extends IVehicleDatabaseManager<Vehicle> {
  VehicleTableManager._();

  static VehicleTableManager instance = VehicleTableManager._();

  factory VehicleTableManager() => instance;

  @override
  String tableName = 'vehicle';

  @override
  Future<List<Vehicle>> getData() async {
    try {
      List<Map<String, Object?>> results = await database!.query(tableName);
      return results.map((e) => Vehicle.fromMap(e)).toList();
    } catch (e) {
      debugPrint(
        "getData<VehicleDatabaseManager> $e",
      );
    }
    return [];
  }

  @override
  Future<Vehicle?> getDataByID(int id) async {
    try {
      List<Map<String, Object?>> results = await database!.query(
        tableName,
        where: '_id = ?',
        whereArgs: [id],
      );

      return Vehicle.fromMap(results.first);
    } catch (e, s) {
      debugPrint(
        "getDataByID<VehicleDatabaseManager> $e\n$s",
      );
    }
    return null;
  }

  @override
  Future<Vehicle?> saveData(Vehicle data) async {
    try {
      int id = await database!.insert(tableName, data.toMap());

      Vehicle? result = await getDataByID(id);
      debugPrint("GOT VEHICLE: ${result.toString()}");
      return result;
    } catch (e) {
      debugPrint(
        "saveData<VehicleDatabaseManager>: $e",
      );
    }
    return null;
  }
}
