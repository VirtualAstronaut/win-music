import 'dart:convert';

import 'package:flutter/material.dart';

class ColorConfig {
  final Color iconColor;
  final Color textColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color borderColor;
  final Color backgroundColor;
  const ColorConfig({
    required this.iconColor,
    required this.textColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.borderColor,
    required this.backgroundColor,
  });

  ColorConfig copyWith({
    Color? iconColor,
    Color? textColor,
    Color? titleColor,
    Color? subtitleColor,
    Color? borderColor,
    Color? backgroundColor,
  }) {
    return ColorConfig(
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iconColor': iconColor.value,
      'textColor': textColor.value,
      'titleColor': titleColor.value,
      'subtitleColor': subtitleColor.value,
      'borderColor': borderColor.value,
      'backgroundColor': backgroundColor.value,
    };
  }

  factory ColorConfig.fromMap(Map<String, dynamic> map) {
    return ColorConfig(
      iconColor: Color(map['iconColor']),
      textColor: Color(map['textColor']),
      titleColor: Color(map['titleColor']),
      subtitleColor: Color(map['subtitleColor']),
      borderColor: Color(map['borderColor']),
      backgroundColor: Color(map['backgroundColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorConfig.fromJson(String source) =>
      ColorConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ColorConfig(iconColor: $iconColor, textColor: $textColor, titleColor: $titleColor, subtitleColor: $subtitleColor, borderColor: $borderColor, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorConfig &&
        other.iconColor == iconColor &&
        other.textColor == textColor &&
        other.titleColor == titleColor &&
        other.subtitleColor == subtitleColor &&
        other.borderColor == borderColor &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return iconColor.hashCode ^
        textColor.hashCode ^
        titleColor.hashCode ^
        subtitleColor.hashCode ^
        borderColor.hashCode ^
        backgroundColor.hashCode;
  }
}
