import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/common/bounds.dart';
import 'package:scoring_pad/presentation/screens/game_settings/free_game_settings.dart';
import 'package:scoring_pad/settings/pref_keys.dart';

import '../models/game_type.dart';
import '../models/standard_game_parameters.dart';
import 'standard_game_engine.dart';

class FreeGameEngine extends StandardGameEngine {
  FreeGameEngine() : super(GameType.free);

  @override
  Widget? getSettingsWidget() => const FreeGameSettings();

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) => const Bounds(min: 2, max: 20);

  @override
  StandardGameParameters getCreationParameters(BuildContext context) {
    final pref = PrefService.of(context);
    return StandardGameParameters(
      highScoreWins: pref.get(fgHighScoreWin),
      maxScoreDefined: pref.get(fgMaxScoreDefined),
      maxScore: pref.get(fgMaxScore),
      authorizedNegativeScore: pref.get(fgAllowNegativeScore),
    );
  }
}
