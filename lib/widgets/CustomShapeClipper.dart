import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 192.65);
    path.lineTo(5.14, 771);
    path.lineTo(417.39, 771);
    path.lineTo(417.39, 200.71);
    path.cubicTo(419.15, 189.58, 416.66, 169.71, 415.19, 161.17);
    path.cubicTo(402.28, 109.05, 356.5, 83.82, 335.23, 77.72);
    path.cubicTo(334.64, 68.93, 328.14, 54.53, 324.96, 48.43);
    path.cubicTo(301.48, 6.85, 257.95, -1.1, 239.12, 0.12);
    path.cubicTo(198.63, 1.87, 172.85, 33.06, 165.02, 48.43);
    path.cubicTo(143.31, 33.21, 115.38, 32.82, 104.13, 34.52);
    path.cubicTo(64.22, 40.97, 45.44, 67.96, 41.04, 80.64);
    path.cubicTo(-35.26, 90.6, -56.78, 159.47, -58, 192.65);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

