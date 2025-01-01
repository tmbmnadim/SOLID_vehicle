import 'shape_properties.dart';

class Trapizoid implements Shape {
  final double topBase;
  final double bottomBase;
  final double height;

  const Trapizoid({
    required this.topBase,
    required this.bottomBase,
    required this.height,
  });

  @override
  double area() {
    return (topBase + bottomBase) * height / 2;
  }

  @override
  double perimeter() {
    return topBase + bottomBase + 2 * height;
  }
}
