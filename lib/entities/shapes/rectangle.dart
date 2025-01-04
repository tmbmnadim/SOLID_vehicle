import "shape_properties.dart";

class Rectangle implements Shape, Sides {
  double height;
  double width;

  Rectangle(this.width, this.height);

  @override
  double area() {
    return height * width;
  }

  @override
  double perimeter() {
    return 2 * (height + width);
  }

  @override
  int sides() {
    return 4;
  }
}
