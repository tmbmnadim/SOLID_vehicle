import 'package:flutter/foundation.dart';
import 'package:solid_principle/sources/local/database_manager.dart';
import '../../entities/vehicles/vehicle_parts.dart';

class WheelsTableManager extends IVehicleDatabaseManager<Wheel> {
  WheelsTableManager._();

  static WheelsTableManager instance = WheelsTableManager._();

  factory WheelsTableManager() => instance;

  @override
  String tableName = 'wheels';

  @override
  Future<List<Wheel>> getData() async {
    try {
      List<Map<String, Object?>> results = await database!.query(tableName);
      return results.map((e) => Wheel.fromMap(e)).toList();
    } catch (e) {
      debugPrint(
        "getData<WheelsTableManager> Couldn't get data from database",
      );
    }
    return [];
  }

  @override
  Future<Wheel?> getDataByID(int id) async {
    try {
      List<Map<String, Object?>> results = await database!.query(
        tableName,
        where: '_id = ?',
        whereArgs: [id],
      );
      return Wheel.fromMap(results.first);
    } catch (e) {
      debugPrint(
        "getDataByID<WheelsTableManager> Couldn't get data from database",
      );
    }
    return null;
  }

  @override
  Future<Wheel?> saveData(Wheel data) async {
    try {
      int id = await database!.insert(tableName, data.toMap());

      Wheel? result = await getDataByID(id);
      return result;
    } catch (e) {
      debugPrint(
        "saveData<WheelsTableManager> Couldn't get data from database",
      );
    }
    return null;
  }
}
