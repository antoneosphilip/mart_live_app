import 'package:flutter/material.dart';
import 'package:live_app/util/app_constants.dart';

ThemeData light({Color color = const Color(0xFF53039D)}) => ThemeData(
      useMaterial3: false,
      fontFamily: AppConstants.fontFamily,
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color)
          .copyWith(background: const Color(0xEFE37CE2))
          .copyWith(error: const Color(0xFFE84D4F)),
    );
