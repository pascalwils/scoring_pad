import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/infrastructure/settings/pref_keys.dart';

enum SkullkingGameMode {
  regular([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
  evenKeeled([2, 2, 4, 4, 6, 6, 8, 8, 10, 10]),
  skipToTheBrawl([6, 7, 8, 9, 10]),
  swiftNSalty([5, 5, 5, 5, 5]),
  broadsideBarrage([10, 10, 10, 10, 10, 10, 10, 10, 10, 10]),
  whirlpool([9, 9, 7, 7, 5, 5, 3, 3, 1, 1]);

  final List<int> nbCards;

  const SkullkingGameMode(this.nbCards);

  static SkullkingGameMode fromString(String name) {
    return SkullkingGameMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SkullkingGameMode.regular,
    );
  }

  static SkullkingGameMode fromPreferences(BuildContext context) {
    return fromString(PrefService.of(context).get(skModePrefKey));
  }
}
