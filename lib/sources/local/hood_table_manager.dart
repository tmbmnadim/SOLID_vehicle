import 'package:flutter/foundation.dart';
import 'package:solid_principle/sources/local/database_manager.dart';
import '../../entities/vehicles/vehicle_parts.dart';

class HoodTableManager extends IVehicleDatabaseManager<Hood> {
  HoodTableManager._();

  static HoodTableManager instance = HoodTableManager._();

  factory HoodTableManager() => instance;

  @override
  String tableName = 'hood';

  @override
  Future<List<Hood>> getData() async {
    try {
      List<Map<String, Object?>> results = await database!.query(tableName);
      return results.map((e) => Hood.fromMap(e)).toList();
    } catch (e) {
      debugPrint(
        "getData<HoodTableManager> Couldn't get data from database",
      );
    }
    return [];
  }

  @override
  Future<Hood?> getDataByID(int id) async {
    try {
      List<Map<String, Object?>> results = await database!.query(
        tableName,
        where: '_id = ?',
        whereArgs: [id],
      );
      return Hood.fromMap(results.first);
    } catch (e) {
      debugPrint(
        "getDataByID<HoodTableManager> Couldn't get data from database",
      );
    }
    return null;
  }

  @override
  Future<Hood?> saveData(Hood data) async {
    try {
      int id = await database!.insert(tableName, data.toMap());

      Hood? result = await getDataByID(id);
      return result;
    } catch (e) {
      debugPrint(
        "saveData<HoodTableManager> Couldn't get data from database",
      );
    }
    return null;
  }
}
