import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_score_calculator.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group(
    "Test getScoreForRound",
    () => {
      test(
        'Test win with Initial rules',
        () {
          final calculator = getSkullkingScoreCalculator(SkullkingRules.initial);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1), 1), 20);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(), 1), 10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(additionalBonuses: 10), 1), 10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(), 4), 40);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(loots: 1), 4), 40);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, pirates: 1), 1), 50);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, skullking: 1), 1), 70);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, skullking: 1, pirates: 1), 2), 100);
        },
      ),
      test(
        'Test win with Since2021 rules',
        () {
          final calculator = getSkullkingScoreCalculator(SkullkingRules.since2021);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1), 1), 20);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(), 1), 10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(additionalBonuses: 10), 1), 20);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(additionalBonuses: -10), 1), 0);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, pirates: 1), 1), 50);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, skullking: 1), 1), 60);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, loots: 1), 1), 40);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, mermaids: 1), 1), 40);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, standard14: 1), 1), 30);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, won: 1, black14: 1), 1), 40);
        },
      ),
      test(
        'Test lost with Initial rules',
        () {
          final calculator = getSkullkingScoreCalculator(SkullkingRules.initial);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(won: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, pirates: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, skullking: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, skullking: 1, pirates: 1), 2), -10);
        },
      ),
      test(
        'Test lost with Since2021 rules',
        () {
          final calculator = getSkullkingScoreCalculator(SkullkingRules.since2021);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(won: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(won: 1, additionalBonuses: -10), 1), -20);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, pirates: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, skullking: 1), 1), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, skullking: 1, pirates: 1), 2), -10);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, rascalBid: 20), 2), -30);
          expect(calculator.getScoreForRound(const SkullkingPlayerRound(bids: 1, rascalBid: 20, additionalBonuses: -10), 2), -40);
        },
      ),
    },
  );
  group(
    "Test getScore",
    () => {
      test('Test 2 rounds with Initial rules', () {
        final calculator = getSkullkingScoreCalculator(SkullkingRules.initial);
        SkullkingGame game = skullkingSimpleGameFixture();
        expect(calculator.getScore(game: game, playerIndex: 0), 30);
      }),
    },
  );
}
