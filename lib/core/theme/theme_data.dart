import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win_music/core/theme/textstyles.dart';
import 'colors.dart';


final lightThemeData = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: titleTextSize,
    ),
    titleSmall: TextStyle(
      fontSize: subtitleTextSize,
    ),
  ),
  fontFamily: 'TitilliumWeb',
  scaffoldBackgroundColor: lightThemeColors.backgroundColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    background: lightThemeColors.backgroundColor,
  ),
  iconTheme: IconThemeData(
    color: lightThemeColors.iconColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: _inputBorder,
    focusedBorder: _focusedInputBorder,
    enabledBorder: _inputBorder,
    prefixIconColor: lightThemeColors.iconColor,
    iconColor: lightThemeColors.iconColor,
  ),
);

final _inputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: lightThemeColors.borderColor,
    width: 1,
  ),
  borderRadius: BorderRadius.zero,
);

final _focusedInputBorder = _inputBorder.copyWith(
  borderSide: _inputBorder.borderSide.copyWith(
    width: 1.2,
  ),
);
final defaultThemeProvider = Provider<ThemeData>((ref) {
  return lightThemeData;
});
