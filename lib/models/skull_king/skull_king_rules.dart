import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pref/pref.dart';

import '../../data/adapter_type_ids.dart';
import '../../settings/pref_keys.dart';

part 'skull_king_rules.g.dart';

@HiveType(typeId: skullKingRulesTypeId)
enum SkullKingRules {
  @HiveField(0)
  initial,
  @HiveField(1)
  since2021;

  static SkullKingRules fromString(String name) {
    return SkullKingRules.values.firstWhere(
          (e) => e.name == name,
      orElse: () => SkullKingRules.initial,
    );
  }

  static SkullKingRules fromPreferences(BuildContext context) {
    return fromString(PrefService.of(context).get(skRulesPrefKey));
  }
}
