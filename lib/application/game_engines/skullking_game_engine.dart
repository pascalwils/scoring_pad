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
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;

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
  Bounds<int> getPlayerNumberBounds() => const Bounds(min: nbMinPlayers, max: nbMaxPlayers);

  @override
  Game createGame(BuildContext context, List<GamePlayer> players) {
    final pref = PrefService.of(context);
    return SkullkingGame(
      players: players,
      mode: SkullkingGameMode.fromPreferences(context),
      lootCardsPresent: pref.get(skLootCardsPrefKey),
      mermaidCardsPresent: pref.get(skMermaidCardsPrefKey),
      advancedPirateAbilitiesEnabled: pref.get(skAdvancedPiratesPrefKey),
      rascalScoringEnabled: pref.get(skRascalScorePrefKey),
    );
  }

  @override
  void endGame(BuildContext context) {
    // TODO: implement endGame
  }
}
