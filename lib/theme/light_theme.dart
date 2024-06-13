import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFFEE4D2D)}) => ThemeData(
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

// ThemeData light({Color color = const Color(0xFFE71C2D)}) => ThemeData(
//       fontFamily: 'Roboto',
//       primaryColor: color,
//       secondaryHeaderColor: Color(0xFFEA3D52),
//       disabledColor: Color(0xFFBABFC4),
//       backgroundColor: Color(0xFFF3F3F3),
//       // 0xFFEEECEC
//       errorColor: Color(0xFFE84D4F),
//       brightness: Brightness.light,
//       hintColor: Color(0xFF0A0A0A),
//       cardColor: Colors.white,
//       colorScheme: ColorScheme.light(primary: color, secondary: color),
//       textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
//     );
