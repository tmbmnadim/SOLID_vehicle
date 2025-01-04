import 'package:flutter/material.dart';
import 'package:solid_principle/entities/vehicles/wheels.dart';

import 'entities/vehicles/bodies.dart';
import 'entities/vehicles/hoods.dart';
import 'view/vehicle_drawer.dart';

void main() {
  runApp(const SOLIDApp());
}

class SOLIDApp extends StatelessWidget {
  const SOLIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          ],
        ),
      ),
    );
  }
}
