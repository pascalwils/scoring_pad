import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';

import 'pref_keys.dart';
import 'pref_theme.dart';

Future<PrefServiceShared> prefServiceInit() async {
  return PrefServiceShared.init(
    defaults: {
      // application
      uiThemePrefKey: PrefTheme.dark.name,
      uiColorPrefKey: Colors.blue.value,
      // skullking
      skModePrefKey: SkullkingGameMode.regular.name,
      skRulesPrefKey: SkullkingRules.initial.name,
      skLootCardsPrefKey: false,
      skAdvancedPiratesPrefKey: false,
      skAdditionalBonusesPrefKey: false,
      skEmojiForBonusTypes: false,
    },
  );
}
