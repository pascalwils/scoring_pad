import 'dart:math';

import 'skullking_game_mode.dart';
import 'skullking_player_round.dart';

import '../game.dart';
import '../game_player.dart';
import '../game_type.dart';
import '../player.dart';

class SkullkingGame implements Game {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;
  static const nbMaxCardsFor8Players = 8;
  static const nbPirates = 6;
  static const nbMermaids = 2;
  static const nbLoots = 2;
  static const nbStandard14s = 3;

  final List<GamePlayer> players;
  int currentRound = 0;
  bool _finished = false;
  late final DateTime _startTime;

  final SkullkingGameMode mode;
  final bool lootCardsPresent;
  final bool mermaidCardsPresent;
  final bool advancedPirateAbilitiesEnabled;
  final bool rascalScoringEnabled;
  late final List<List<SkullkingPlayerRound>> rounds;

  SkullkingGame({
    required this.players,
    required this.mode,
    this.lootCardsPresent = true,
    this.mermaidCardsPresent = true,
    this.advancedPirateAbilitiesEnabled = true,
    this.rascalScoringEnabled = false,
  }) {
    assert(players.length >= nbMinPlayers);
    assert(players.length <= nbMaxPlayers);

    _startTime = DateTime.now();

    int nbRounds = mode.nbCards.length;
    rounds = List.filled(players.length, List.filled(nbRounds, SkullkingPlayerRound()));
  }

  SkullkingGame.fromDatasource({
    required this.players,
    required this.currentRound,
    required bool finished,
    required DateTime startTime,
    required this.mode,
    required this.lootCardsPresent,
    required this.mermaidCardsPresent,
    required this.advancedPirateAbilitiesEnabled,
    required this.rascalScoringEnabled,
    required this.rounds,
  })  : _finished = finished,
        _startTime = startTime;

  int nbCards() {
    int result = mode.nbCards[currentRound];
    if (players.length == nbMaxPlayers) {
      result = min(result, nbMaxCardsFor8Players);
    }
    return result;
  }

  void editRound(int roundNumber, List<SkullkingPlayerRound> round) {
    rounds[roundNumber - 1] = round;
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
