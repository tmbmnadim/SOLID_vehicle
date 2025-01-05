import 'package:solid_principle/entities/shapes/rectangle.dart';
import 'package:solid_principle/entities/shapes/trapizoid.dart';

import '../shapes/shape_properties.dart';
import '../shapes/circle.dart';

abstract class VehiclePart {
  String get id;
  String get name;
  String get description;
  Shape get partShape;
}

class Wheel implements VehiclePart {
  @override
  final String description;

  @override
  final String id;

  @override
  final String name;

  @override
  final Circle partShape;

  final double horizontalPosition;
  final double verticalPosition;
  final double tireRadius;
  final double rimRadius;
  final double tireRimRatio;
  final double radius;

  Wheel({
    required this.id,
    required this.description,
    required this.name,
    required this.horizontalPosition,
    required this.verticalPosition,
    required this.radius,
    this.tireRimRatio = 1 / 3,
  })  : partShape = Circle(radius),
        tireRadius = _calculateTireRadius(radius, tireRimRatio),
        rimRadius = _calculateRimRadius(radius, tireRimRatio);

  static double _calculateTireRadius(double radius, double tireRimRatio) {
    return tireRimRatio * radius;
  }

  static double _calculateRimRadius(double radius, double tireRimRatio) {
    return (1 - tireRimRatio) * radius;
  }

  factory Wheel.fromMap(Map<String, Object?> map) {
    return Wheel(
      id: map['id'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      horizontalPosition: map['horizontalPosition'] as double,
      verticalPosition: map['verticalPosition'] as double,
      radius: map['radius'] as double,
      tireRimRatio: map['tireRimRatio'] as double,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'horizontalPosition': horizontalPosition,
      'verticalPosition': verticalPosition,
      'radius': radius,
      'tireRimRatio': tireRimRatio,
    };
  }
}

class Body implements VehiclePart {
  @override
  final String description;

  @override
  final String id;

  @override
  final String name;

  @override
  final Rectangle partShape;

  final double length;
  final double height;

  Body({
    required this.description,
    required this.id,
    required this.name,
    required this.length,
    required this.height,
  }) : partShape = Rectangle(length, height);

  factory Body.fromMap(Map<String, Object?> map) {
    return Body(
      id: map['id'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      length: map['length'] as double,
      height: map['height'] as double,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'length': length,
      'height': height,
    };
  }
}

class Hood implements VehiclePart {
  @override
  final String id;

  @override
  final String description;

  @override
  final String name;

  @override
  final Trapizoid partShape;

  final double topLength;
  final double bottomLength;
  final double height;
  final double position;

  Hood({
    required this.description,
    required this.id,
    required this.name,
    required this.position,
    required this.topLength,
    required this.bottomLength,
    required this.height,
  })  : assert(
            position >= 0 && position <= 1, 'Position must be between 0 and 1'),
        partShape = Trapizoid(
          topBase: topLength,
          bottomBase: bottomLength,
          height: height,
        );

  factory Hood.fromMap(Map<String, Object?> map) {
    return Hood(
      id: map['id'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      position: map['position'] as double,
      topLength: map['topLength'] as double,
      bottomLength: map['bottomLength'] as double,
      height: map['height'] as double,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'position': position,
      'topLength': topLength,
      'bottomLength': bottomLength,
      'height': height,
    };
  }
}
