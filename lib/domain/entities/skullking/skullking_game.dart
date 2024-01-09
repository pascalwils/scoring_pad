import 'dart:math';

import 'package:scoring_pad/domain/entities/game_type.dart';
import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';

import '../game.dart';

class SkullkingGame implements Game {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;
  static const nbMaxCardsFor8Players = 8;
  static const nbPirates = 5;
  static const nbMermaids = 2;

  final List<Player> players;
  int currentRound = 0;
  bool _finished = false;
  late final DateTime _startTime;

  final SkullkingGameMode mode;
  final bool lootCardsPresent;
  final bool mermaidCardsPresent;
  final bool advancedPirateAbitilitiesEnabled;
  final bool rascalScoringEnabled;
  late final List<List<SkullkingPlayerRound>> rounds;

  SkullkingGame({
    required this.players,
    required this.mode,
    this.lootCardsPresent = true,
    this.mermaidCardsPresent = true,
    this.advancedPirateAbitilitiesEnabled = true,
    this.rascalScoringEnabled = false,
  }) {
    assert(players.length >= nbMinPlayers);
    assert(players.length <= nbMaxPlayers);

    _startTime = DateTime.now();

    int nbRounds = mode.nbCards.length;
    rounds = List.filled(players.length, List.filled(nbRounds, SkullkingPlayerRound()));
  }

  int nbCards() {
    int result = mode.nbCards[currentRound];
    if (players.length == nbMaxPlayers) {
      result = min(result, nbMaxCardsFor8Players);
    }
    return result;
  }

  int nbMaxPiratesCaptured() {
    return max(players.length - 1, nbPirates);
  }

  void editRound(int roundNumber, List<SkullkingPlayerRound> round) {
    rounds[roundNumber - 1] = round;
  }

  @override
  List<Player> getPlayers() => players;

  @override
  List<List<int>> getRounds() {
    return rounds.map((it) => it.map((round) => round.score).toList()).toList();
  }

  @override
  DateTime getStartTime() => _startTime;

  @override
  bool isFinished() => _finished;

  @override
  GameType getGameType() => GameType.Skullking;
}
