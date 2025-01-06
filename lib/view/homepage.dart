import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<Vehicle>? vehicles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 150,
          ),
          DrawVehicle(
            hood: TruckHood(),
            body: TruckBody(),
            leftWheel: CarWheel(),
            rightWheel: CarWheel(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
