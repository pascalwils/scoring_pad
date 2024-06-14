import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/models/game.dart';

import '../../managers/current_game_manager.dart';
import '../../models/game_player.dart';
import '../../models/skull_king/skull_king_game.dart';
import '../../models/skull_king/skull_king_game_mode.dart';
import '../../models/skull_king/skull_king_player_game.dart';
import '../../models/skull_king/skull_king_player_round.dart';
import '../../models/skull_king/skull_king_rules.dart';
import '../../models/skull_king/skull_king_game_parameters.dart';
import '../../common/bounds.dart';
import '../../settings/pref_keys.dart';
import '../../presentation/screens/game_settings/skull_king_game_settings.dart';
import '../../presentation/screens/skull_king/skull_king_round_screen.dart';

import '../presentation/screens/skull_king/skull_king_end_screen.dart';
import 'game_engine.dart';

class SkullKingGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context, WidgetRef ref, List<GamePlayer> players) {
    SkullKingGame game = _createGame(context, players);
    ref.read(currentGameManager.notifier).startGame(players, game);
    context.go(SkullKingRoundScreen.path);
  }

  @override
  void continueGame(BuildContext context, WidgetRef ref) {
    final currentGame = ref.read(currentGameManager).game as SkullKingGame;
    if (currentGame.currentRound < currentGame.nbRounds()) {
      context.go(SkullKingRoundScreen.path);
    } else {
      endGame(context);
    }
  }

  @override
  Widget? getSettingsWidget() => const SkullkingGameSettings();

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) =>
      Bounds(min: SkullKingGame.nbMinPlayers, max: SkullKingGame.getNbMaxPlayers(SkullKingRules.fromPreferences(context)));

  SkullKingGame _createGame(BuildContext context, List<GamePlayer> players) {
    final pref = PrefService.of(context);
    final parameters = SkullKingGameParameters(
      mode: SkullKingGameMode.fromPreferences(context),
      rules: SkullKingRules.fromPreferences(context),
      lootCardsPresent: pref.get(skLootCardsPrefKey),
      advancedPirateAbilitiesEnabled: pref.get(skAdvancedPiratesPrefKey),
      additionalBonusesEnabled: pref.get(skAdditionalBonusesPrefKey),
    );
    int nbRounds = parameters.mode.nbCards.length;
    final rounds = List<SkullKingPlayerGame>.generate(
      players.length,
      (_) => SkullKingPlayerGame(rounds: List.filled(nbRounds, const SkullKingPlayerRound())),
    );
    return SkullKingGame(
      players: players,
      parameters: parameters,
      currentRound: 0,
      finished: false,
      startTime: DateTime.now(),
      playerGames: rounds,
    );
  }

  @override
  void endGame(BuildContext context) {
    context.go(SkullKingEndScreen.path);
  }
}
