import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() => ThemeData(
        fontFamily: 'Satoshi',
        colorSchemeSeed: const Color(0xffF1B2B9),
        brightness: Brightness.light,
        useMaterial3: true,
      );
}
