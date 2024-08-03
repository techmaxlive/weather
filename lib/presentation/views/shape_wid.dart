import 'package:flutter/material.dart';

class EdgeCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cutSize = 20.0; // Size of the cut

    Path path = Path();
    path.moveTo(0, cutSize);
    path.lineTo(cutSize, 0);
    path.lineTo(size.width - cutSize, 0);
    path.lineTo(size.width, cutSize);
    path.lineTo(size.width, size.height - cutSize);
    path.lineTo(size.width - cutSize, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class WavyEdgeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     double waveHeight = 10.0;

//     path.lineTo(0, size.height - waveHeight);
//     for (double i = 0; i < size.width; i += 20) {
//       path.quadraticBezierTo(
//           i + 10, size.height, i + 20, size.height - waveHeight);
//     }
//     path.lineTo(size.width, waveHeight);
//     for (double i = size.width; i > 0; i -= 20) {
//       path.quadraticBezierTo(i - 10, 0, i - 20, waveHeight);
//     }
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

class WavyEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double waveHeight = 10.0;
    double waveLength = 20.0;

    var path = Path();
    path.moveTo(0, waveHeight);

    for (double i = 0; i < size.width; i += waveLength) {
      path.quadraticBezierTo(
          i + waveLength / 4, 0, i + waveLength / 2, waveHeight);
      path.quadraticBezierTo(
          i + 3 * waveLength / 4, 2 * waveHeight, i + waveLength, waveHeight);
    }

    path.lineTo(size.width, size.height - waveHeight);

    for (double i = size.width; i > 0; i -= waveLength) {
      path.quadraticBezierTo(i - waveLength / 4, size.height,
          i - waveLength / 2, size.height - waveHeight);
      path.quadraticBezierTo(
          i - 3 * waveLength / 4,
          size.height - 2 * waveHeight,
          i - waveLength,
          size.height - waveHeight);
    }

    path.lineTo(0, waveHeight);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
