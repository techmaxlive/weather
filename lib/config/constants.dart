import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const String appName = 'Weather and News App';
  static var fontFamily = GoogleFonts.ubuntu().fontFamily;
}

class ImagePath {
  static const String homebg = 'assets/bg_img.png';
  static const String sunny = 'assets/sunny_bg_1.png';
  static const String nightBg = 'assets/night_bg.png';
}

class AppColors {
  static const Color primaryColor = Colors.pink;
  static const Color lightPrimaryColor = Color(0xFFB2DFDB);
  static const Color darkPrimaryColor = Color.fromARGB(255, 193, 26, 82);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF303030);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color.fromARGB(255, 61, 61, 61);
  static const Color yellow = Colors.amber;
  static const Color blue = Colors.blue;
}
