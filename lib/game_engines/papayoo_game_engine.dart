import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/game_player.dart';
import '../models/game_type.dart';
import '../models/standard_game.dart';
import '../managers/current_game_manager.dart';
import '../common/bounds.dart';
import '../models/standard_game_parameters.dart';
import '../presentation/screens/standard_game/standard_game_end_screen.dart';
import '../presentation/screens/standard_game/standard_game_round_screen.dart';
import 'game_engine.dart';
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
