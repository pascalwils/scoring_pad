import 'package:flutter/material.dart';

import '../models/game_type.dart';
import '../common/bounds.dart';
import '../models/standard_game_parameters.dart';
import 'standard_game_engine.dart';

class PapayooGameEngine extends StandardGameEngine {
  static const int nbMinPlayers = 3;
  static const int nbMaxPlayers = 8;
  static const parameters = StandardGameParameters(
    highScoreWins: false,
    maxScoreDefined: true,
    maxScore: 250,
    authorizedNegativeScore: false,
  );

  PapayooGameEngine() : super(GameType.papayoo);

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
    return "papayoo";
  }
}
