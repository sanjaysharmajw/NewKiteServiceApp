import 'package:flutter/material.dart';

class AppBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = 100;
    var path = Path();
    path.lineTo(0, height - 0);
    path.quadraticBezierTo(width / 2, height, width, height - 0);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}