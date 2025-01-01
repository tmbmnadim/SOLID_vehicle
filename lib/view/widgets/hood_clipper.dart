import 'package:flutter/material.dart';

class HoodClipper extends CustomClipper<Path> {
  final double topLength;
  final double bottomLength;

  HoodClipper({required this.topLength, required this.bottomLength});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double height = size.height;
    final double width = size.width;

    final double topOffset = (width - topLength) / 2;
    final double bottomOffset = (width - bottomLength) / 2;

    path.moveTo(topOffset, 0);
    path.lineTo(width - topOffset, 0);
    path.lineTo(width - bottomOffset, height);
    path.lineTo(bottomOffset, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
