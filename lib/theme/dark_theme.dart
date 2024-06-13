import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xFFEE4D2D)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: Color(0xFFEE4D2D),
      disabledColor: Color(0xFFBABFC4),
      // backgroundColor: Color(0xFFF3F3F3),
      // errorColor: Color(0xFFEE4D2D),
      brightness: Brightness.light,
      hintColor: Color(0xFF0A0A0A),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: color,
        secondary: color,
        background: Color(0xFFF3F3F3),
        error: Color(0xFFEE4D2D),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: color),
      ),
    );
