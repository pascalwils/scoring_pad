import 'dart:math';

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
  static const nbMaxPlayersOldRules = 6;
  static const nbMaxCardsFor8Players = 9;

  static const nbPirates = 6;
  static const nbMermaids = 2;
  static const nbLoots = 2;
  static const nbStandard14s = 3;

  final List<GamePlayer> players;
  final int currentRound;
  final bool finished;
  late final DateTime startTime;

  final SkullkingGameMode mode;
  final SkullkingRules rules;
  final bool lootCardsPresent;
  final bool advancedPirateAbilitiesEnabled;
  final bool additionalBonuses;
  late final List<SkullkingPlayerGame> rounds;

  SkullkingGame._({
    required this.players,
    required this.mode,
    required this.rules,
    required this.currentRound,
    required this.lootCardsPresent,
    required this.advancedPirateAbilitiesEnabled,
    required this.additionalBonuses,
    required this.finished,
    required this.startTime,
    required this.rounds,
  });

  SkullkingGame({
    required this.players,
    required this.mode,
    required this.rules,
    required this.currentRound,
    this.lootCardsPresent = false,
    this.advancedPirateAbilitiesEnabled = false,
    this.additionalBonuses = false,
    this.finished = false,
  }) {
    assert(players.length >= nbMinPlayers);
    assert(players.length <= nbMaxPlayers);

    startTime = DateTime.now();

    int nbRounds = mode.nbCards.length;
    rounds = List.filled(players.length, SkullkingPlayerGame(nbRounds));
  }

  SkullkingGame.fromDatasource({
    required this.players,
    required this.currentRound,
    required this.finished,
    required this.startTime,
    required this.mode,
    required this.rules,
    required this.lootCardsPresent,
    required this.advancedPirateAbilitiesEnabled,
    required this.additionalBonuses,
    required this.rounds,
  });

  SkullkingGame copyWith({
    List<GamePlayer>? players,
    int? currentRound,
    bool? finished,
    SkullkingGameMode? mode,
    SkullkingRules? rules,
    bool? lootCardsPresent,
    bool? advancedPirateAbilitiesEnabled,
    bool? additionalBonuses,
    List<SkullkingPlayerGame>? rounds,
  }) {
    return SkullkingGame._(
      players: players ?? this.players,
      mode: mode ?? this.mode,
      rules: rules ?? this.rules,
      currentRound: currentRound ?? this.currentRound,
      finished: finished ?? this.finished,
      lootCardsPresent: lootCardsPresent ?? this.lootCardsPresent,
      advancedPirateAbilitiesEnabled: advancedPirateAbilitiesEnabled ?? this.advancedPirateAbilitiesEnabled,
      additionalBonuses: additionalBonuses ?? this.additionalBonuses,
      rounds: rounds ?? this.rounds,
      startTime: startTime,
    );
  }

  static int getNbMaxPlayers(SkullkingRules rules) =>
      switch (rules) { SkullkingRules.initial => nbMaxPlayersOldRules, _ => nbMaxPlayers };

  int nbCards() {
    int result = mode.nbCards[currentRound];
    if (players.length == nbMaxPlayers) {
      result = min(result, nbMaxCardsFor8Players);
    }
    return result;
  }

  int nbRounds() {
    return rounds[0].rounds.length;
  }

  @override
  List<Player> getPlayers() => players.map((e) => Player(name: e.name)).toList();

  @override
  DateTime getStartTime() => startTime;

  @override
  bool isFinished() => finished;

  @override
  GameType getGameType() => GameType.skullking;
}
