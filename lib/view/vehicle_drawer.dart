import "package:flutter/material.dart";

import "../utils/vehicles/vehicle_parts.dart";
import "widgets/hood_clipper.dart";

class DrawVehicle extends StatelessWidget {
  final Hood hood;
  final Body body;
  final Wheel leftWheel;
  final Wheel rightWheel;
  const DrawVehicle({
    super.key,
    required this.hood,
    required this.body,
    required this.leftWheel,
    required this.rightWheel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildBody(),
        _buildHood(),
        _buildWheel(leftWheel, isLeft: true),
        _buildWheel(rightWheel, isLeft: false),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      width: body.partShape.width,
      height: body.partShape.height,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildHood() {
    return Positioned(
      top: -hood.partShape.height + 2,
      left: body.partShape.width * hood.position -
          hood.partShape.bottomBase * hood.position,
      child: ClipPath(
        clipper: HoodClipper(
          topLength: hood.partShape.topBase,
          bottomLength: hood.partShape.bottomBase,
        ),
        child: Container(
          height: hood.partShape.height,
          width: hood.partShape.bottomBase,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWheel(Wheel wheel, {required bool isLeft}) {
    return Positioned(
      bottom: wheel.verticalPosition * -wheel.partShape.radius,
      left: isLeft
          ? wheel.horizontalPosition * body.partShape.width -
              wheel.partShape.radius
          : null,
      right: isLeft
          ? null
          : wheel.horizontalPosition * body.partShape.width -
              wheel.partShape.radius,
      child: Container(
        width: wheel.partShape.radius * 2,
        height: wheel.partShape.radius * 2,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
