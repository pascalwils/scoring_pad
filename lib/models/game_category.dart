import 'package:flutter/foundation.dart';

enum GameCategory {
  Dice,
  Card,
  Board,
  Free;

  static GameCategory getFromString(String? value) => values.firstWhere((e) => describeEnum(e) == value);
}
