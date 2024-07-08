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
  final Color unselectedButtonBackground;

  PlayerColorScheme({
    required this.base,
    required this.background,
    required this.text,
    required this.buttonBackground,
    required this.unselectedButtonBackground,
  });

  factory PlayerColorScheme.darken(Color base) {
    return PlayerColorScheme(
      base: base,
      background: darken(base, .3),
      text: computeOnColor(darken(base, .3)),
      buttonBackground: darken(base, .2),
      unselectedButtonBackground: darken(darken(base, .2)),
    );
  }

  factory PlayerColorScheme.lighten(Color base) {
    return PlayerColorScheme(
      base: base,
      background: lighten(base, .3),
      text: computeOnColor(lighten(base, .3)),
      buttonBackground: lighten(base, .2),
      unselectedButtonBackground: lighten(lighten(base, .2)),
    );
  }
}

class GraphColorScheme {
  final Color gridColor;
  final Color borderColor;
  final Color tooltipBackground;

  GraphColorScheme.light()
      : gridColor = Colors.black12,
        borderColor = Colors.black26,
        tooltipBackground = Colors.white.withOpacity(0.8);

  GraphColorScheme.dark()
      : gridColor = Colors.white12,
        borderColor = Colors.white10,
        tooltipBackground = Colors.black.withOpacity(0.8);
}

class DismissibleColorScheme {
  final Color disabledBackground;
  final Color enabledBackground;

  DismissibleColorScheme.light()
      : disabledBackground = Colors.white30,
        enabledBackground = Colors.red;

  DismissibleColorScheme.dark()
      : disabledBackground = Colors.white30,
        enabledBackground = const Color(0xFFFE4A49);
}

int getNbColorsInPalette() => baseColors.length;

extension ColorSchemeExtension on ColorScheme {
  static final List<PlayerColorScheme> _darkPlayerColorSchemes = baseColors.map((it) => PlayerColorScheme.darken(it)).toList();
  static final List<PlayerColorScheme> _lightPlayerColorSchemes = baseColors.map((it) => PlayerColorScheme.lighten(it)).toList();
  static final GraphColorScheme _darkGraphColorScheme = GraphColorScheme.dark();
  static final GraphColorScheme _lightGraphColorScheme = GraphColorScheme.light();
  static final DismissibleColorScheme _darkDismissibleColorScheme = DismissibleColorScheme.dark();
  static final DismissibleColorScheme _lightDismissibleColorScheme = DismissibleColorScheme.light();

  List<PlayerColorScheme> get playerSchemes => brightness == Brightness.light ? _lightPlayerColorSchemes : _darkPlayerColorSchemes;

  GraphColorScheme get graphScheme => brightness == Brightness.light ? _lightGraphColorScheme : _darkGraphColorScheme;

  DismissibleColorScheme get dismissibleScheme =>
      brightness == Brightness.light ? _darkDismissibleColorScheme : _lightDismissibleColorScheme;
}
