import 'package:flutter/material.dart';
import 'package:solid_principle/utils/vehicles/wheels.dart';

import 'utils/vehicles/bodies.dart';
import 'utils/vehicles/hoods.dart';
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
