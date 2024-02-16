import 'package:flutter/material.dart';
import 'package:pref/pref.dart';

import 'skullking_game_mode.dart';
import 'skullking_player_round.dart';

import '../../../infrastructure/settings/pref_keys.dart';
import '../game.dart';
import '../game_player.dart';
import '../game_type.dart';
import '../player.dart';

enum SkullkingRules {
  initial,
  since2021;

  static SkullkingRules fromString(String name) {
    return SkullkingRules.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SkullkingRules.initial,
    );
  }

  static SkullkingRules fromPreferences(BuildContext context) {
    return fromString(PrefService.of(context).get(skRulesPrefKey));
  }
}

class SkullkingGame implements Game {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;
  static const nbPirates = 6;
  static const nbMermaids = 2;
  static const nbLoots = 2;
  static const nbStandard14s = 3;

  final List<GamePlayer> players;
  int currentRound = 0;
  bool _finished = false;
  late final DateTime _startTime;

  final SkullkingGameMode mode;
  final SkullkingRules rules;
  final bool lootCardsPresent;
  final bool advancedPirateAbilitiesEnabled;
  final bool additionalBonuses;
  late final List<SkullkingPlayerGame> rounds;

  SkullkingGame({
    required this.players,
    required this.mode,
    required this.rules,
    this.lootCardsPresent = false,
    this.advancedPirateAbilitiesEnabled = false,
    this.additionalBonuses = false,
  }) {
    assert(players.length >= nbMinPlayers);
    assert(players.length <= nbMaxPlayers);

    _startTime = DateTime.now();

    int nbRounds = mode.nbCards.length;
    rounds = List.filled(players.length, SkullkingPlayerGame(nbRounds));
  }

  SkullkingGame.fromDatasource({
    required this.players,
    required this.currentRound,
    required bool finished,
    required DateTime startTime,
    required this.mode,
    required this.rules,
    required this.lootCardsPresent,
    required this.advancedPirateAbilitiesEnabled,
    required this.additionalBonuses,
    required this.rounds,
  })  : _finished = finished,
        _startTime = startTime;

  int nbCards() {
    return mode.nbCards[currentRound];
  }

  int nbRounds() {
    return rounds[0].rounds.length;
  }

  @override
  List<Player> getPlayers() => players.map((e) => Player(name: e.name)).toList();

  @override
  DateTime getStartTime() => _startTime;

  @override
  bool isFinished() => _finished;

  @override
  GameType getGameType() => GameType.skullking;
}
