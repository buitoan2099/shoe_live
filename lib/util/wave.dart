import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height/3.5);
    // path.lineTo(size.width, size.height/2);

    path.quadraticBezierTo(
        size.width/2 , size.height/5*3,
        size.width, size.height/5*3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveParClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double si = 100;
    size = Size(si,si*15/9);
    var path = Path();
    // path.lineTo(size.width, size.height/2);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width*5/4 , size.height/10*7,
        size.width, 0);
    path.lineTo(size.width*4/5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}