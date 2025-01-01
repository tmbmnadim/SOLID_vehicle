import 'vehicle_parts.dart';

class CarBody extends Body {
  static const String _defaultId = "car_body";
  static const String _defaultName = "Car Body";
  static const String _defaultDescription = "The body of a car";
  static const double _defaultLength = 100;
  static const double _defaultHeight = 50;

  CarBody({
    super.id = _defaultId,
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.length = _defaultLength,
    super.height = _defaultHeight,
  });
}

class TruckBody extends Body {
  static const String _defaultId = "truck_body";
  static const String _defaultName = "Truck Body";
  static const String _defaultDescription = "The body of a truck";
  static const double _defaultLength = 120;
  static const double _defaultHeight = 60;

  TruckBody({
    super.id = _defaultId,
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.length = _defaultLength,
    super.height = _defaultHeight,
  });
}
