import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/domain/entities/game.dart';
import 'package:scoring_pad/domain/entities/game_player.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';
import 'package:scoring_pad/infrastructure/common/bounds.dart';
import 'package:scoring_pad/infrastructure/settings/pref_keys.dart';
import 'package:scoring_pad/presentation/screens/game_settings/skullking_game_settings.dart';
import 'package:scoring_pad/presentation/screens/specific/skullking_round_screen.dart';

import 'game_engine.dart';

class SkullkingGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context) {
    context.go(SkullkingRoundScreen.path);
  }

  @override
  void continueGame(BuildContext context) {
    context.go(SkullkingRoundScreen.path);
  }

  @override
  Widget? getSettingsWidget() => const SkullkingGameSettings();

  @override
  Bounds<int> getPlayerNumberBounds(BuildContext context) =>
      Bounds(min: SkullkingGame.nbMinPlayers, max: SkullkingGame.getNbMaxPlayers(SkullkingRules.fromPreferences(context)));

  @override
  Game createGame(BuildContext context, List<GamePlayer> players) {
    final pref = PrefService.of(context);
    return SkullkingGame(
      players: players,
      mode: SkullkingGameMode.fromPreferences(context),
      rules: SkullkingRules.fromPreferences(context),
      currentRound: 0,
      lootCardsPresent: pref.get(skLootCardsPrefKey),
      advancedPirateAbilitiesEnabled: pref.get(skAdvancedPiratesPrefKey),
      additionalBonuses: pref.get(skAdditionalBonusesPrefKey),
    );
  }

  @override
  void endGame(BuildContext context) {
    // TODO: implement endGame
  }
}
