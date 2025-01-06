import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solid_principle/view/homepage.dart';
import 'sources/local/vehicle_table_manager.dart';

void main() {
  runApp(const SOLIDApp());
}

class SOLIDApp extends StatelessWidget {
  const SOLIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: VehicleTableManager().initDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Homepage();
          }
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
