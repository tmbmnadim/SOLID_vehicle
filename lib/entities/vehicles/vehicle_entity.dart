import 'vehicle_parts.dart';

class Vehicle {
  final int? id;
  final String name;
  final double price;
  final Hood? hood;
  final Body? body;
  final Wheel? frontWheel;
  final Wheel? backWheel;

  Vehicle({
    required this.id,
    required this.name,
    required this.price,
    required this.hood,
    required this.body,
    required this.frontWheel,
    required this.backWheel,
  });

  Vehicle copyWith({
    int? id,
    String? name,
    double? price,
    Hood? hood,
    Body? body,
    Wheel? frontWheel,
    Wheel? backWheel,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      hood: hood ?? this.hood,
      body: body ?? this.body,
      frontWheel: frontWheel ?? this.frontWheel,
      backWheel: backWheel ?? this.backWheel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'hood': hood?.id,
      'body': body?.id,
      'frontWheel': frontWheel?.id,
      'backWheel': backWheel?.id,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    Map<String, Object?> hood = {};
    Map<String, Object?> body = {};
    Map<String, Object?> frontWheel = {};
    Map<String, Object?> backWheel = {};
    if (map['hood'] is String) {
      hood = {'id': map['hood']};
    } else {
      hood = map['hood'] ?? {'id': null};
    }

    if (map['body'] is String) {
      body = {'id': map['body']};
    } else {
      body = map['body'] ?? {'id': null};
    }

    if (map['frontWheel'] is String) {
      frontWheel = {'id': map['frontWheel']};
    } else {
      frontWheel = map['frontWheel'] ?? {'id': null};
    }

    if (map['backWheel'] is String) {
      backWheel = {'id': map['backWheel']};
    } else {
      backWheel = map['backWheel'] ?? {'id': null};
    }

    return Vehicle(
      id: map['_id'],
      name: map['name'],
      price: map['price'],
      hood: Hood.fromMap(hood),
      body: Body.fromMap(body),
      frontWheel: Wheel.fromMap(frontWheel),
      backWheel: Wheel.fromMap(backWheel),
    );
  }
}
