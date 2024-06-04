import 'package:flutter/material.dart';
import 'package:pref/pref.dart';

import '../models/skull_king/skull_king_game_mode.dart';
import '../models/skull_king/skull_king_rules.dart';
import 'pref_keys.dart';
import 'pref_theme.dart';

Future<PrefServiceShared> prefServiceInit() async {
  return PrefServiceShared.init(
    defaults: {
      // application
      uiThemePrefKey: PrefTheme.dark.name,
      uiColorPrefKey: Colors.blue.value,
      // skullking
      skModePrefKey: SkullKingGameMode.regular.name,
      skRulesPrefKey: SkullKingRules.initial.name,
      skLootCardsPrefKey: false,
      skAdvancedPiratesPrefKey: false,
      skAdditionalBonusesPrefKey: false,
      skEmojiForBonusTypes: false,
    },
  );
}
