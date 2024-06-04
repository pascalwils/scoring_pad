import 'skull_king_game.dart';
import 'skull_king_player_round.dart';
import 'skull_king_rules.dart';
import 'skull_king_round_field.dart';

abstract class SkullKingScoreCalculator {
  static const pointsForWonBids = 20;
  static const pointsForLostBids = 10;
  static const pointsPerWonRound = 10;
  static const pointsForPirate = 30;

  int getScore({required SkullKingGame game, required int playerIndex, int? toRoundIndex}) {
    int result = 0;
    toRoundIndex = toRoundIndex ?? game.currentRound;
    for (int i = 0; i <= toRoundIndex; i++) {
      final round = game.playerGames[playerIndex].getRound(i);
      result += getScoreForRound(round, game.parameters.mode.nbCards[i]);
    }
    return result;
  }

  int getScoreForRound(SkullKingPlayerRound round, int nbCards) {
    int result = 0;
    if (round.getValue(SkullKingRoundField.bids) == round.getValue(SkullKingRoundField.won)) {
      if (round.getValue(SkullKingRoundField.bids) == 0) {
        result += nbCards * pointsPerWonRound;
      } else {
        result += round.getValue(SkullKingRoundField.bids) * pointsForWonBids;
      }
      result += round.getValue(SkullKingRoundField.pirates) * pointsForPirate;
      result += _getSpecificWinScoreForRound(round);
    } else {
      if (round.getValue(SkullKingRoundField.bids) == 0) {
        result -= nbCards * pointsForLostBids;
      } else {
        result -= (round.getValue(SkullKingRoundField.bids) - round.getValue(SkullKingRoundField.won)).abs() * pointsForLostBids;
      }
      result -= _getSpecificLostScoreForRound(round);
    }
    return result;
  }

  int _getSpecificWinScoreForRound(SkullKingPlayerRound round);

  int _getSpecificLostScoreForRound(SkullKingPlayerRound round) {
    return 0;
  }
}

class InitialSkullKingScoreCalculator extends SkullKingScoreCalculator {
  static const pointsForSkullKing = 50;

  @override
  int _getSpecificWinScoreForRound(SkullKingPlayerRound round) {
    return round.getValue(SkullKingRoundField.skullKing) * pointsForSkullKing;
  }
}

class Sin2021SkullKingScoreCalculator extends SkullKingScoreCalculator {
  static const pointsForMermaid = 20;
  static const pointsForLoot = 20;
  static const pointsForStandard14 = 10;
  static const pointsForBlack14 = 20;
  static const pointsForSkullKing = 40;

  @override
  int _getSpecificWinScoreForRound(SkullKingPlayerRound round) {
    int result = 0;
    result += round.getValue(SkullKingRoundField.skullKing) * pointsForSkullKing;
    result += round.getValue(SkullKingRoundField.mermaids) * pointsForMermaid;
    result += round.getValue(SkullKingRoundField.loots) * pointsForLoot;
    result += round.getValue(SkullKingRoundField.standard14) * pointsForStandard14;
    result += round.getValue(SkullKingRoundField.black14) * pointsForBlack14;
    result += round.getValue(SkullKingRoundField.rascalBid);
    result += round.getValue(SkullKingRoundField.bonuses);
    return result;
  }

  @override
  int _getSpecificLostScoreForRound(SkullKingPlayerRound round) {
    return round.getValue(SkullKingRoundField.rascalBid) - round.getValue(SkullKingRoundField.bonuses);
  }
}

SkullKingScoreCalculator getSkullKingScoreCalculator(SkullKingRules rules) => switch (rules) {
      SkullKingRules.initial => InitialSkullKingScoreCalculator(),
      SkullKingRules.since2021 => Sin2021SkullKingScoreCalculator(),
    };