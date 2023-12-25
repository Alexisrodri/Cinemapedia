import 'package:flutter/material.dart';

class AppTheme {

  final Brightness theme;

  AppTheme({required this.theme});


  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      brightness: theme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ));
}
