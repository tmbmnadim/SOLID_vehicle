import "shape_properties.dart";

class Circle implements Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() {
    return 3.14 * radius * radius;
  }

  @override
  double perimeter() {
    return 2 * 3.14 * radius;
  }
}
