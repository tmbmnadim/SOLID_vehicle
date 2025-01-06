import 'vehicle_parts.dart';

class CarHood extends Hood {
  static const String _defaultName = "Car Body";
  static const String _defaultDescription = "The body of a car";
  static const double _defaultPosition = 0.5;
  static const double _defaultTopLength = 60;
  static const double _defaultBottomLength = 80;
  static const double _defaultHeight = 30;

  CarHood({
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.position = _defaultPosition,
    super.topLength = _defaultTopLength,
    super.bottomLength = _defaultBottomLength,
    super.height = _defaultHeight,
  });
}

class TruckHood extends Hood {
  static const String _defaultName = "Truck Hood";
  static const String _defaultDescription = "The body of a truck";
  static const double _defaultPosition = 0;
  static const double _defaultTopLength = 40;
  static const double _defaultBottomLength = 50;
  static const double _defaultHeight = 40;

  TruckHood({
    super.name = _defaultName,
    super.description = _defaultDescription,
    super.position = _defaultPosition,
    super.topLength = _defaultTopLength,
    super.bottomLength = _defaultBottomLength,
    super.height = _defaultHeight,
  });
}
