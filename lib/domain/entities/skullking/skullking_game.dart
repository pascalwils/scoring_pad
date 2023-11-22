import 'dart:math';

import 'package:scoring_pad/domain/entities/game.dart';
import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';

class SkullkingGame extends Game {
  static const nbMinPlayers = 2;
  static const nbMaxPlayers = 8;
  static const nbMaxCardsFor8Players = 8;
  static const nbPirates = 5;
  static const nbMermaids = 2;

  final SkullkingGameMode mode;
  final bool lootCardsPresent;
  final bool mermaidCardsPresent;
  final bool advancedPirateAbitilitiesEnabled;
  final bool rascalScoringEnabled;
  late final List<List<SkullkingPlayerRound>> rounds;

  SkullkingGame({
    required this.mode,
    required List<Player> players,
    this.lootCardsPresent = true,
    this.mermaidCardsPresent = true,
    this.advancedPirateAbitilitiesEnabled = true,
    this.rascalScoringEnabled = false,
  }) : super(players: players) {
    assert(players.length >= nbMinPlayers);
    assert(players.length <= nbMaxPlayers);

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
    int i = 0;
    for (SkullkingPlayerRound r in round) {
      rounds[roundNumber - 1][i] = r;
      i++;
    }
  }
}
