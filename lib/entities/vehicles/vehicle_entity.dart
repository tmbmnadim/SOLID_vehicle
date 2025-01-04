import 'package:solid_principle/entities/vehicles/vehicle_parts.dart';

class Vehicle {
  final int id;
  final String name;
  final double price;
  final Hood hood;
  final Body body;
  final Wheel frontWheels;
  final Wheel backWheels;

  Vehicle({
    required this.id,
    required this.name,
    required this.price,
    required this.hood,
    required this.body,
    required this.frontWheels,
    required this.backWheels,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'hood': hood.id,
      'body': body.id,
      'frontWheels': frontWheels.id,
      'backWheels': backWheels.id,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      hood: Hood.fromId(map['hood']),
      body: Body.fromId(map['body']),
      frontWheels: Wheel.fromId(map['frontWheels']),
      backWheels: Wheel.fromId(map['backWheels']),
    );
  }
}
