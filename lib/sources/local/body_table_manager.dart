import 'package:flutter/foundation.dart';
import 'package:solid_principle/sources/local/database_manager.dart';
import '../../entities/vehicles/vehicle_parts.dart';

class BodyTableManager extends IVehicleDatabaseManager<Body> {
  BodyTableManager._();

  static BodyTableManager instance = BodyTableManager._();

  factory BodyTableManager() => instance;

  @override
  String tableName = 'body';

  @override
  Future<List<Body>> getData() async {
    try {
      List<Map<String, Object?>> results = await database!.query(tableName);
      return results.map((e) => Body.fromMap(e)).toList();
    } catch (e) {
      debugPrint(
        "getData<BodyTableManager> Couldn't get data from database",
      );
    }
    return [];
  }

  @override
  Future<Body?> getDataByID(int id) async {
    try {
      List<Map<String, Object?>> results = await database!.query(
        tableName,
        where: '_id = ?',
        whereArgs: [id],
      );
      return Body.fromMap(results.first);
    } catch (e) {
      debugPrint(
        "getDataByID<BodyTableManager> Couldn't get data from database",
      );
    }
    return null;
  }

  @override
  Future<Body?> saveData(Body data) async {
    try {
      int id = await database!.insert(tableName, data.toMap());

      Body? result = await getDataByID(id);
      return result;
    } catch (e) {
      debugPrint(
        "saveData<BodyTableManager> Couldn't get data from database",
      );
    }
    return null;
  }
}
