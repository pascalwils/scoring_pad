import 'package:scoring_pad/models/skull_king/skull_king_game.dart';
import 'package:scoring_pad/models/skull_king/skull_king_player_round.dart';
import 'package:scoring_pad/models/skull_king/skull_king_round_field.dart';
import 'package:scoring_pad/models/skull_king/skull_king_rules.dart';
import 'package:scoring_pad/models/skull_king/skull_king_score_calculator.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group(
    "Test getScoreForRound",
    () => {
      test(
        'Test win with Initial rules',
        () {
          final calculator = getSkullKingScoreCalculator(SkullKingRules.initial);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1}), 1),
              20);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(), 1), 10);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.bonuses: 10}), 1), 10);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(), 4), 40);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.loots: 1}), 4), 40);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                    fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.pirates: 1},
                  ),
                  1),
              50);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                    fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.skullKing: 1},
                  ),
                  1),
              70);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                    fields: {
                      SkullKingRoundField.bids: 1,
                      SkullKingRoundField.won: 1,
                      SkullKingRoundField.skullKing: 1,
                      SkullKingRoundField.pirates: 1,
                    },
                  ),
                  2),
              100);
        },
      ),
      test(
        'Test win with Since2021 rules',
        () {
          final calculator = getSkullKingScoreCalculator(SkullKingRules.since2021);
          expect(
              calculator.getScoreForRound(
                  SkullKingPlayerRound(
                    fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1},
                  ),
                  1),
              20);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(), 1), 10);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.bonuses: 10}), 1), 20);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.bonuses: -10}), 1), 0);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.pirates: 1}),
                  1),
              50);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.skullKing: 1}),
                  1),
              60);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.loots: 1}),
                  1),
              40);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.mermaids: 1}),
                  1),
              40);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.standard14: 1}),
                  1),
              30);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.won: 1, SkullKingRoundField.black14: 1}),
                  1),
              40);
        },
      ),
      test(
        'Test lost with Initial rules',
        () {
          final calculator = getSkullKingScoreCalculator(SkullKingRules.initial);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1}), 1), -10);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.won: 1}), 1), -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.pirates: 1}), 1),
              -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.skullKing: 1}), 1),
              -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.skullKing: 1, SkullKingRoundField.pirates: 1}),
                  2),
              -10);
        },
      ),
      test(
        'Test lost with Since2021 rules',
        () {
          final calculator = getSkullKingScoreCalculator(SkullKingRules.since2021);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1}), 1), -10);
          expect(calculator.getScoreForRound(const SkullKingPlayerRound(fields: {SkullKingRoundField.won: 1}), 1), -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.won: 1, SkullKingRoundField.bonuses: -10}), 1),
              -20);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.pirates: 1}), 1),
              -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.skullKing: 1}), 1),
              -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.skullKing: 1, SkullKingRoundField.pirates: 1}),
                  2),
              -10);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.rascalBid: 20}), 2),
              -30);
          expect(
              calculator.getScoreForRound(
                  const SkullKingPlayerRound(
                      fields: {SkullKingRoundField.bids: 1, SkullKingRoundField.rascalBid: 20, SkullKingRoundField.bonuses: -10}),
                  2),
              -40);
        },
      ),
    },
  );

  group(
    "Test getScore",
    () => {
      test('Test 2 rounds with Initial rules', () {
        final calculator = getSkullKingScoreCalculator(SkullKingRules.initial);
        SkullKingGame game = skullkingSimpleGameFixture();
        expect(calculator.getScore(game: game, playerIndex: 0), 30);
      }),
    },
  );
}
