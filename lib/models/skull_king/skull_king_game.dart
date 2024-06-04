import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'skull_king_game_parameters.dart';
import 'skull_king_rules.dart';
import 'skull_king_player_game.dart';

import '../../data/adapter_type_ids.dart';
import '../game.dart';
import '../game_player.dart';
import '../game_type.dart';
import '../player.dart';

part 'skull_king_game.freezed.dart';
part 'skull_king_game.g.dart';

@freezed
class SkullKingGame with _$SkullKingGame implements Game {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;
  static const nbMaxPlayersOldRules = 6;
  static const nbMaxCardsFor8Players = 9;

  static const nbPirates = 6;
  static const nbMermaids = 2;
  static const nbLoots = 2;
  static const nbStandard14s = 3;

  const SkullKingGame._();

  @HiveType(typeId: skullKingGameTypeId, adapterName: "SkullKingGameAdapter")
  const factory SkullKingGame({
    @HiveField(0)
    required List<GamePlayer> players,
    @HiveField(1)
    required int currentRound,
    @HiveField(2)
    required bool finished,
    @HiveField(3)
    required DateTime startTime,
    @HiveField(4)
    required SkullKingGameParameters parameters,
    @HiveField(5)
    required List<SkullKingPlayerGame> playerGames,
  }) = _SkullKingGame;

  static int getNbMaxPlayers(SkullKingRules rules) =>
      switch (rules) {
        SkullKingRules.initial => nbMaxPlayersOldRules, _ => nbMaxPlayers
      };

  int nbCards({int? roundIndex}) {
    int result = parameters.mode.nbCards[roundIndex ?? currentRound];
    if (players.length == nbMaxPlayers) {
      result = min(result, nbMaxCardsFor8Players);
    }
    return result;
  }

  int nbRounds() {
    return playerGames[0].rounds.length;
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
