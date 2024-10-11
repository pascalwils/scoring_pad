import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/presentation/widgets/score_graph_widget.dart';

import '../models/skull_king/skull_king_game_mode.dart';
import '../models/skull_king/skull_king_rules.dart';
import 'pref_keys.dart';
import 'pref_locale.dart';
import 'pref_theme.dart';

Future<PrefServiceShared> prefServiceInit() async {
  return PrefServiceShared.init(
    defaults: {
      // application
      uiThemePrefKey: PrefTheme.dark.name,
      uiColorPrefKey: Colors.blue.value,
      graphCurveShapePrefKey: GraphCurveShape.curved.name,
      localePrefKey: PrefLocale.fromCurrentLocale().getId(),
      // skullking
      skModePrefKey: SkullKingGameMode.regular.name,
      skRulesPrefKey: SkullKingRules.initial.name,
      skLootCardsPrefKey: false,
      skAdvancedPiratesPrefKey: false,
      skAdditionalBonusesPrefKey: false,
      skEmojiForBonusTypes: false,
      skRascalScoreMode: false,
      skRascalCannonball: false,
      // free game
      fgHighScoreWin: true,
      fgMaxScoreDefined: false,
      fgMaxScore: 0,
      fgAllowNegativeScore: false,
    },
  );
}


