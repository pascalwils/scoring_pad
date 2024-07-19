import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/common/bounds.dart';
import 'package:scoring_pad/game_engines/game_engine.dart';
import 'package:scoring_pad/models/game_player.dart';
import 'package:scoring_pad/models/game_type.dart';
import 'package:scoring_pad/presentation/screens/game_settings/free_game_settings.dart';
import 'package:scoring_pad/settings/pref_keys.dart';

import '../managers/current_game_manager.dart';
import '../models/standard_game.dart';
import '../models/standard_game_parameters.dart';
import '../presentation/screens/standard_game/standard_game_round_screen.dart';

class FreeGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context, WidgetRef ref, List<GamePlayer> players) {
    StandardGame game = _createGame(context, players);
    ref.read(currentGameManager.notifier).startGame(players, game);
    context.go(StandardGameRoundScreen.path);
  }

  @override
  void continueGame(BuildContext context, WidgetRef ref) {
    final currentGame = ref.read(currentGameManager).game as StandardGame;
    if (currentGame.isFinished()) {
      endGame(context);
    } else {
      context.go(StandardGameRoundScreen.path);
    }
  }

  @override
  Widget? getSettingsWidget() => const FreeGameSettings();

  @override
  void endGame(BuildContext context) {
    // TODO: implement endGame
  }

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) => const Bounds(min: 2, max: 20);

  StandardGame _createGame(BuildContext context, List<GamePlayer> players) {
    final pref = PrefService.of(context);
    final parameters = StandardGameParameters(
      highScoreWins: pref.get(fgHighScoreWin),
      maxScoreDefined: pref.get(fgMaxScoreDefined),
      maxScore: pref.get(fgMaxScore),
    );
    return StandardGame(
      type: GameType.free,
      players: players,
      currentRound: 0,
      finished: false,
      startTime: DateTime.now(),
      parameters: parameters,
      rounds: List.filled(players.length, List.empty()),
    );
  }
}
