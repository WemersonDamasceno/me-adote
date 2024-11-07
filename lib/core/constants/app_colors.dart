import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFFB228);
  static const background = Color(0xFF1b1f23);
  static const grey = Color(0xFFCCCCCC);
  static const startGradiente = Color(0xFFFFB228);
  static const endGradiente = Color(0xFFFFFFFF);
  static const linearColors = LinearGradient(
    colors: [
      AppColors.startGradiente,
      AppColors.endGradiente,
    ],
  );
}
