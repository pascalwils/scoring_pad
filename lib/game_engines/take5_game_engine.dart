import 'package:flutter/material.dart';

import '../models/game_type.dart';
import '../common/bounds.dart';
import '../models/standard_game_parameters.dart';
import 'standard_game_engine.dart';

class Take5GameEngine extends StandardGameEngine {
  static const int nbMinPlayers = 2;
  static const int nbMaxPlayers = 10;
  static const parameters = StandardGameParameters(
    highScoreWins: false,
    endScoreDefined: true,
    endScore: 67,
  );

  Take5GameEngine() : super(GameType.take5);

  @override
  Widget? getSettingsWidget() => null;

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) => const Bounds(min: nbMinPlayers, max: nbMaxPlayers);

  @override
  StandardGameParameters getCreationParameters(BuildContext context) {
    return parameters;
  }

  @override
  String? getRulesFilename(BuildContext context) {
    return "take5";
  }
}
