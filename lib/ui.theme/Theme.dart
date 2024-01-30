import 'package:flutter/material.dart';

final DarkColorPalette = ThemeData.dark().copyWith(
  primaryColor: Color(0xFF6200EE),
  // Add other dark theme colors as needed
);

final LightColorPalette = ThemeData.light().copyWith(
  primaryColor: Color(0xFF6200EE),
  // Add other light theme colors as needed
);

ThemeData rootineTheme(bool darkTheme, Widget content) {
  return darkTheme ? DarkColorPalette : LightColorPalette;
}

