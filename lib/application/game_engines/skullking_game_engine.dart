import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/infrastructure/common/bounds.dart';
import 'package:scoring_pad/presentation/screens/game_settings/skullking_game_settings.dart';
import 'package:scoring_pad/presentation/screens/specific/skullking_round_screen.dart';

import 'game_engine.dart';

class SkullkingGameEngine extends GameEngine {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;

  @override
  void startGame(BuildContext context) {
    context.go(SkullkingRoundScreen.path);
  }

  @override
  void continueGame(BuildContext context) {
    // TODO: implement continueGame
  }

  @override
  Widget? getSettingsWidget() => const SkullkingGameSettings();

  @override
  Bounds<int> getPlayerNumberBounds() => const Bounds(min: nbMinPlayers, max: nbMaxPlayers);
}
