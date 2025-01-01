import "shape_properties.dart";

class Square implements Shape, Sides {
  double side;

  Square(this.side);

  @override
  double area() {
    return side * side;
  }

  @override
  double perimeter() {
    return 4 * side;
  }

  @override
  int sides() {
    return 4;
  }
}
