import 'package:flutter/material.dart';
import 'package:scoring_pad/presentation/graphic_tools.dart';

const List<Color> baseColors = [
  Color(0xffe6194B),
  Color(0xff3cb44b),
  Color(0xffffe119),
  Color(0xff4363d8),
  Color(0xfff58231),
  Color(0xff911eb4),
  Color(0xff42d4f4),
  Color(0xfff032e6),
  Color(0xffbfef45),
  Color(0xfffabed4),
];

class PlayerColorScheme {
  final Color base;
  final Color background;
  final Color text;
  final Color buttonBackground;

  PlayerColorScheme({required this.base, required this.background, required this.text, required this.buttonBackground});

  factory PlayerColorScheme.darken(Color base) {
    return PlayerColorScheme(
      base: base,
      background: darken(base, .3),
      text: computeOnColor(darken(base, .3)),
      buttonBackground: darken(base, .2),
    );
  }

  factory PlayerColorScheme.lighten(Color base) {
    return PlayerColorScheme(
      base: base,
      background: lighten(base, .3),
      text: computeOnColor(lighten(base, .3)),
      buttonBackground: lighten(base, .2),
    );
  }
}

List<PlayerColorScheme> darkColorSchemes = [
  PlayerColorScheme.darken(baseColors[0]),
  PlayerColorScheme.darken(baseColors[1]),
  PlayerColorScheme.darken(baseColors[2]),
  PlayerColorScheme.darken(baseColors[3]),
  PlayerColorScheme.darken(baseColors[4]),
  PlayerColorScheme.darken(baseColors[5]),
  PlayerColorScheme.darken(baseColors[6]),
  PlayerColorScheme.darken(baseColors[7]),
  PlayerColorScheme.darken(baseColors[8]),
  PlayerColorScheme.darken(baseColors[9]),
];

List<PlayerColorScheme> lightColorSchemes = [
  PlayerColorScheme.lighten(baseColors[0]),
  PlayerColorScheme.lighten(baseColors[1]),
  PlayerColorScheme.lighten(baseColors[2]),
  PlayerColorScheme.lighten(baseColors[3]),
  PlayerColorScheme.lighten(baseColors[4]),
  PlayerColorScheme.lighten(baseColors[5]),
  PlayerColorScheme.lighten(baseColors[6]),
  PlayerColorScheme.lighten(baseColors[7]),
  PlayerColorScheme.lighten(baseColors[8]),
  PlayerColorScheme.lighten(baseColors[9]),
];

int getNbColorsInPalette() => baseColors.length;

List<Color> getColorPalette(Brightness brightness) {
  return baseColors;
}

PlayerColorScheme getColorScheme(Brightness brightness, int index) {
  return brightness == Brightness.dark ? darkColorSchemes[index] : lightColorSchemes[index];
}
