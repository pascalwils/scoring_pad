import 'package:flutter/material.dart';

Color computeColorForText(Color background) {
  return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

Color computeDimmedColorForText(Color background) {
  return background.computeLuminance() > 0.5 ? Colors.black38 : Colors.white38;
}

Color computeOnColor(Color background, [double amount = .1]) {
  return background.computeLuminance() > 0.5 ? darken(background, amount) : lighten(background, amount);
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
