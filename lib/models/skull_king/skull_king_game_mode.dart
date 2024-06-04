import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pref/pref.dart';

import '../../settings/pref_keys.dart';
import '../../data/adapter_type_ids.dart';

part 'skull_king_game_mode.g.dart';

@HiveType(typeId: skullKingGameModeTypeId)
enum SkullKingGameMode {
  @HiveField(0)
  regular([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
  @HiveField(1)
  evenKeeled([2, 2, 4, 4, 6, 6, 8, 8, 10, 10]),
  @HiveField(2)
  skipToTheBrawl([6, 7, 8, 9, 10]),
  @HiveField(3)
  swiftNSalty([5, 5, 5, 5, 5]),
  @HiveField(4)
  broadsideBarrage([10, 10, 10, 10, 10, 10, 10, 10, 10, 10]),
  @HiveField(5)
  whirlpool([9, 9, 7, 7, 5, 5, 3, 3, 1, 1]);

  final List<int> nbCards;

  const SkullKingGameMode(this.nbCards);

  static SkullKingGameMode fromString(String name) {
    return SkullKingGameMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SkullKingGameMode.regular,
    );
  }

  static SkullKingGameMode fromPreferences(BuildContext context) {
    return fromString(PrefService.of(context).get(skModePrefKey));
  }
}
