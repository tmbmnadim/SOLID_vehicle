import 'vehicle_parts.dart';

class CarWheel extends Wheel {
  static const String _defaultId = "car_wheel";
  static const String _defaultName = "Car Wheel";
  static const String _defaultDescription = "A wheel for a car";
  static const double _defaultHorizontalPosition = 0.2;
  static const double _defaultVerticalPosition = 1;
  static const double _defaultRadius = 18;

  CarWheel({
    super.id = _defaultId,
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.horizontalPosition = _defaultHorizontalPosition,
    super.verticalPosition = _defaultVerticalPosition,
    super.radius = _defaultRadius,
  });
}

class TruckWheel extends Wheel {
  static const String _defaultId = "truck_wheel";
  static const String _defaultName = "Truck Wheel";
  static const String _defaultDescription = "A wheel for a truck";
  static const double _defaultHorizontalPosition = -20;
  static const double _defaultVerticalPosition = -18;
  static const double _defaultRadius = 30;

  TruckWheel({
    super.id = _defaultId,
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.horizontalPosition = _defaultHorizontalPosition,
    super.verticalPosition = _defaultVerticalPosition,
    super.radius = _defaultRadius,
  });
}
