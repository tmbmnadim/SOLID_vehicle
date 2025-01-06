import 'package:flutter/foundation.dart';

import '../entities/vehicles/vehicle_entity.dart';
import '../entities/vehicles/vehicle_parts.dart';
import '../sources/local/body_table_manager.dart';
import '../sources/local/hood_table_manager.dart';
import '../sources/local/vehicle_table_manager.dart';
import '../sources/local/wheels_table_manager.dart';

class VehicleRepository {
  final VehicleTableManager vehicleTableManager;
  final HoodTableManager hoodTableManager;
  final BodyTableManager bodyTableManager;
  final WheelsTableManager wheelsTableManager;

  VehicleRepository._({
    required this.vehicleTableManager,
    required this.hoodTableManager,
    required this.bodyTableManager,
    required this.wheelsTableManager,
  });

  static VehicleRepository? _instance;

  factory VehicleRepository({
    required VehicleTableManager vehicleTableManager,
    required HoodTableManager hoodTableManager,
    required BodyTableManager bodyTableManager,
    required WheelsTableManager wheelsTableManager,
  }) {
    _instance ??= VehicleRepository._(
      vehicleTableManager: vehicleTableManager,
      hoodTableManager: hoodTableManager,
      bodyTableManager: bodyTableManager,
      wheelsTableManager: wheelsTableManager,
    );
    return _instance!;
  }

  Future<List<Vehicle>> getVehicles() async {
    try {
      List<Vehicle> output = [];
      List<Vehicle> results = await vehicleTableManager.getData();
      for (var vehicle in results) {
        Hood? hood = await hoodTableManager.getDataByID(vehicle.hood!.id!);

        Body? body = await bodyTableManager.getDataByID(vehicle.body!.id!);

        Wheel? frontWheel =
            await wheelsTableManager.getDataByID(vehicle.frontWheel!.id!);

        Wheel? backWheel =
            await wheelsTableManager.getDataByID(vehicle.backWheel!.id!);

        output.add(
          vehicle.copyWith(
            hood: hood,
            body: body,
            frontWheel: frontWheel,
            backWheel: backWheel,
          ),
        );
      }
    } catch (e) {
      debugPrint(
        "getVehicles<VehicleRepository> $e",
      );
    }
    return [];
  }

  Future<Vehicle?> getVehicleByID(int id) async {
    try {
      Vehicle? result = await vehicleTableManager.getDataByID(id);

      Hood? hood = await hoodTableManager.getDataByID(result!.hood!.id!);

      Body? body = await bodyTableManager.getDataByID(result.body!.id!);

      Wheel? frontWheel =
          await wheelsTableManager.getDataByID(result.frontWheel!.id!);

      Wheel? backWheel =
          await wheelsTableManager.getDataByID(result.backWheel!.id!);

      return result.copyWith(
        hood: hood,
        body: body,
        frontWheel: frontWheel,
        backWheel: backWheel,
      );
    } catch (e) {
      debugPrint(
        "getVehicleByID<VehicleRepository> $e",
      );
    }
    return null;
  }

  Future<Vehicle?> saveVehicle(Vehicle vehicle) async {
    try {
      Hood? hood = await hoodTableManager.saveData(vehicle.hood!);
      Body? body = await bodyTableManager.saveData(vehicle.body!);
      Wheel? frontWheel =
          await wheelsTableManager.saveData(vehicle.frontWheel!);
      Wheel? backWheel = await wheelsTableManager.saveData(vehicle.backWheel!);
      Vehicle newVehicle = vehicle.copyWith(
        hood: hood,
        body: body,
        frontWheel: frontWheel,
        backWheel: backWheel,
      );
      Vehicle? result = await vehicleTableManager.saveData(newVehicle);
      return result;
    } catch (e) {
      debugPrint(
        "saveVehicle<VehicleRepository> $e",
      );
    }
    return null;
  }
}
