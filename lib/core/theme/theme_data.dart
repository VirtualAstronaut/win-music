import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'colors.dart';

part 'theme_data.g.dart';

final lightThemeData = ThemeData(
  fontFamily: 'TitilliumWeb',
  colorScheme: const ColorScheme.light(
    background: Colors.white,
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
// @riverpod
// class ThemeData extends _$ThemeData {
//   @override
//    build() {
//     return ;
//   }
// }

@riverpod
class DefaultTheme extends _$DefaultTheme {
  @override
  ThemeData build() {
    return lightThemeData;
  }
}
