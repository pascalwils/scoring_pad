import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/models/game.dart';

import '../models/game_player.dart';
import '../models/game_type.dart';
import '../models/standard_game.dart';
import '../managers/current_game_manager.dart';
import '../common/bounds.dart';
import 'game_engine.dart';

class PapayooGameEngine extends GameEngine {
  static const int nbMinPlayers = 3;
  static const int nbMaxPlayers = 8;

  @override
  void startGame(BuildContext context, WidgetRef ref, List<GamePlayer> players) {
    StandardGame game = _createGame(context, players);
    ref.read(currentGameManager.notifier).startGame(players, game);
    //context.go(PapayooRoundScreen.path);
  }

  @override
  void continueGame(BuildContext context, WidgetRef ref) {}

  @override
  Widget? getSettingsWidget() => null;

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) => const Bounds(min: nbMinPlayers, max: nbMaxPlayers);

  @override
  void endGame(BuildContext context) {
    // TODO: implement endGame
  }

  StandardGame _createGame(BuildContext context, List<GamePlayer> players) {
    return StandardGame(
      type: GameType.papayoo,
      players: players,
      currentRound: 0,
      finished: false,
      startTime: DateTime.now(),
      rounds: List.filled(players.length, List<int>.empty(growable: true)),
    );
  }
}
