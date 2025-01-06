import 'package:flutter/material.dart';
import 'package:solid_principle/entities/vehicles/vehicle_entity.dart';
import 'package:solid_principle/sources/local/vehicle_table_manager.dart';

import '../entities/vehicles/bodies.dart';
import '../entities/vehicles/hoods.dart';
import '../entities/vehicles/wheels.dart';
import 'vehicle_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Vehicle? vehicle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          DrawVehicle(
            hood: TruckHood(),
            body: TruckBody(),
            leftWheel: CarWheel(),
            rightWheel: CarWheel(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              vehicle = await VehicleTableManager().saveData(
                Vehicle(
                  id: 1,
                  name: "TEST",
                  price: 1000,
                  hood: TruckHood(),
                  body: TruckBody(),
                  frontWheel: CarWheel(),
                  backWheel: CarWheel(),
                ),
              );

              setState(() {});
            },
            child: const Text("Add Vehicle"),
          ),
          const SizedBox(height: 20),
          Text(vehicle?.toMap().toString() ?? ""),
        ],
      ),
    );
  }
}
