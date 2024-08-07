import 'package:flutter/material.dart';

class BottomCPaint extends CustomPainter {
  final Color color;
  BottomCPaint({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0602410);
    path_0.quadraticBezierTo(size.width * 0.0084068, size.height * -0.0015060,
        size.width * 0.0338983, 0);
    path_0.quadraticBezierTo(size.width * 0.2033898, size.height * 0.0413855,
        size.width * 0.2542373, size.height * 0.0481928);
    path_0.cubicTo(
        size.width * 0.3898305,
        size.height * 0.0481928,
        size.width * 0.6440678,
        size.height * 0.0481928,
        size.width * 0.7796610,
        size.height * 0.0481928);
    path_0.cubicTo(
        size.width * 0.8417966,
        size.height * 0.0386747,
        size.width * 0.9210508,
        size.height * -0.0043373,
        size.width * 0.9661017,
        0);
    path_0.quadraticBezierTo(size.width * 1.0009492, size.height * 0.0067470,
        size.width, size.height * 0.0602410);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.quadraticBezierTo(
        0, size.height * 0.7650602, 0, size.height * 0.0602410);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class WavyEdgeContainer extends StatelessWidget {
//   final Widget child;

//   WavyEdgeContainer({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: WavyEdgeClipper(),
//       child: child,
//     );
//   }
// }

// class WavyEdgeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();

//     path.lineTo(0, size.height);

//     final double waveHeight = 10;
//     final double waveWidth = 15;
//     final int waveCount = (size.width / waveWidth).toInt();

//     for (int i = 0; i <= waveCount; i++) {
//       path.lineTo(
//           i * waveWidth, size.height - (i % 2 == 0 ? waveHeight : -waveHeight));
//     }

//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
class WavyEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double waveHeight = 10;
    double waveLength = 28;

    // Top wavy edge
    path.lineTo(0, waveHeight);
    for (double i = 0; i < size.width; i += waveLength) {
      path.quadraticBezierTo(
          i + waveLength / 4, 0, i + waveLength / 2, waveHeight);
      path.quadraticBezierTo(
          i + 3 * waveLength / 4, 2 * waveHeight, i + waveLength, waveHeight);
    }

    // Right edge
    path.lineTo(size.width, size.height - waveHeight);

    // Bottom wavy edge
    for (double i = size.width; i > 0; i -= waveLength) {
      path.quadraticBezierTo(i - waveLength / 4, size.height,
          i - waveLength / 2, size.height - waveHeight);
      path.quadraticBezierTo(
          i - 3 * waveLength / 4,
          size.height - 2 * waveHeight,
          i - waveLength,
          size.height - waveHeight);
    }

    // Left edge
    path.lineTo(0, waveHeight);

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
//     double waveLength = 20.0;

//     // Top wavy edge
//     path.lineTo(0, waveHeight);
//     for (double i = 0; i < size.width; i += waveLength) {
//       path.quadraticBezierTo(
//           i + waveLength / 4, 0, i + waveLength / 2, waveHeight);
//       path.quadraticBezierTo(
//           i + 3 * waveLength / 4, 2 * waveHeight, i + waveLength, waveHeight);
//     }

//     // Right edge
//     path.lineTo(size.width, size.height - waveHeight);

//     // Bottom wavy edge
//     for (double i = size.width; i > 0; i -= waveLength) {
//       path.quadraticBezierTo(i - waveLength / 4, size.height,
//           i - waveLength / 2, size.height - waveHeight);
//       path.quadraticBezierTo(
//           i - 3 * waveLength / 4,
//           size.height - 2 * waveHeight,
//           i - waveLength,
//           size.height - waveHeight);
//     }

//     // Left edge
//     path.lineTo(0, waveHeight);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
