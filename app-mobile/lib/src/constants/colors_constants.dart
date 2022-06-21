import 'package:flutter/material.dart';

class ColorConstants {
  static const primaryColor = Color(0xFFFFB228);
  static const cinzaColor = Color(0xFFB1B1B1);
  static const cinzaTextColor = Color(0xFF3A3A3A);
  static const startGradiente = Color(0xFFFFB228);
  static const endGradiente = Color(0xFFFFFFFF);
  static const linearColors = LinearGradient(
    colors: [
      ColorConstants.startGradiente,
      ColorConstants.endGradiente,
    ],
  );
}
