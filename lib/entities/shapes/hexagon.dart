import "shape_properties.dart";

class Hexagon implements Shape, Sides {
  double side;

  Hexagon(this.side);

  @override
  double area() {
    return (3 * 1.732) / 2 * side * side;
  }

  @override
  double perimeter() {
    return 6 * side;
  }

  @override
  int sides() {
    return 6;
  }
}
