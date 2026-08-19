import 'package:flutter/material.dart';

/// Local Nunito styles — no runtime Google Fonts fetch.
class PpText {
  static const String family = 'Nunito';

  static TextStyle nunito({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
