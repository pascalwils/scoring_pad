import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';

abstract class SkullkingScoreCalculator {
  static const pointsForWonBids = 20;
  static const pointsForLostBids = 10;
  static const pointsPerWonRound = 10;
  static const pointsForPirate = 30;

  int getScore({required SkullkingGame game, required int playerIndex, int? toRoundIndex}) {
    int result = 0;
    toRoundIndex = toRoundIndex ?? game.currentRound;
    for (int i = 0; i <= toRoundIndex; i++) {
      final round = game.rounds[playerIndex].getRound(i);
      result += getScoreForRound(round, game.mode.nbCards[i]);
    }
    return result;
  }

  int getScoreForRound(SkullkingPlayerRound round, int nbCards) {
    int result = 0;
    if (round.bids == round.won) {
      if (round.bids == 0) {
        result += nbCards * pointsPerWonRound;
      } else {
        result += round.bids * pointsForWonBids;
      }
      result += round.pirates * pointsForPirate;
      result += _getSpecificWinScoreForRound(round);
    } else {
      if (round.bids == 0) {
        result -= nbCards * pointsForLostBids;
      } else {
        result -= (round.bids - round.won).abs() * pointsForLostBids;
      }
      result -= _getSpecificLostScoreForRound(round);
    }
    return result;
  }

  int _getSpecificWinScoreForRound(SkullkingPlayerRound round);

  int _getSpecificLostScoreForRound(SkullkingPlayerRound round) {
    return 0;
  }
}

class InitialSkullkingScoreCalculator extends SkullkingScoreCalculator {
  static const pointsForSkullKing = 50;

  @override
  int _getSpecificWinScoreForRound(SkullkingPlayerRound round) {
    return round.skullking * pointsForSkullKing;
  }
}

class Sin2021SkullkingScoreCalculator extends SkullkingScoreCalculator {
  static const pointsForMermaid = 20;
  static const pointsForLoot = 20;
  static const pointsForStandard14 = 10;
  static const pointsForBlack14 = 20;
  static const pointsForSkullKing = 40;

  @override
  int _getSpecificWinScoreForRound(SkullkingPlayerRound round) {
    int result = 0;
    result += round.skullking * pointsForSkullKing;
    result += round.mermaids * pointsForMermaid;
    result += round.loots * pointsForLoot;
    result += round.standard14 * pointsForStandard14;
    result += round.black14 * pointsForBlack14;
    result += round.rascalBid;
    result += round.additionalBonuses;
    return result;
  }

  @override
  int _getSpecificLostScoreForRound(SkullkingPlayerRound round) {
    return round.rascalBid - round.additionalBonuses;
  }
}

SkullkingScoreCalculator getSkullkingScoreCalculator(SkullkingRules rules) => switch (rules) {
      SkullkingRules.initial => InitialSkullkingScoreCalculator(),
      SkullkingRules.since2021 => Sin2021SkullkingScoreCalculator(),
    };
