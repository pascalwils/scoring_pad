import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/domain/entities/game.dart';
import 'package:scoring_pad/domain/entities/game_player.dart';

import '../../domain/entities/player.dart';
import '../../infrastructure/common/bounds.dart';
import '../../presentation/screens/players_selection/player_selection_screen.dart';
import '../../presentation/screens/players_selection/player_selection_state.dart';
import 'game_engine.dart';

class PapayooGameEngine extends GameEngine {
  static const int nbMinPlayers = 3;
  static const int nbMaxPlayers = 8;

  @override
  void startGame(BuildContext context) async {
  }

  @override
  void continueGame(BuildContext context) {}

  @override
  Widget? getSettingsWidget() => null;

  @override
  Bounds<int> getPlayerNumberBounds() => const Bounds(min: nbMinPlayers, max: nbMaxPlayers);

  @override
  Game createGame(BuildContext context, List<GamePlayer> players) {
    // TODO: implement createGame
    throw UnimplementedError();
  }

  @override
  void endGame(BuildContext context) {
    // TODO: implement endGame
  }
}
