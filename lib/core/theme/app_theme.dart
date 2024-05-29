import 'package:blog/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
