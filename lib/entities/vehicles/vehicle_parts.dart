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
    required this.description,
    required this.id,
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

  Wheel.fromId(String id) : id = id;
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
}

class Hood implements VehiclePart {
  @override
  final String description;

  @override
  final String id;

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
}
