import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_score_calculator.dart';
import 'package:test/test.dart';

void main() {
  test('Check first turn win', () {
    final calculator = getSkullkingScoreCalculator(SkullkingRules.initial);
    SkullkingPlayerRound round = const SkullkingPlayerRound();
    expect(calculator.getScoreForRound(round, 0), 10);
  });
}