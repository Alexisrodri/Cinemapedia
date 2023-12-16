import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({this.isDarkMode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ));

  AppTheme copywith({
    bool? isDarkMode,
  }) =>
      AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}
