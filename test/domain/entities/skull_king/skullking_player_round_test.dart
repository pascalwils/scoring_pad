import 'package:flutter_test/flutter_test.dart';
import 'package:scoring_pad/models/skull_king/skull_king_player_round.dart';
import 'package:scoring_pad/models/skull_king/skull_king_round_field.dart';

void main() {
  group(
    "Test skullking round constructors",
    () {
      test(
        'Test empty constructor',
        () {
          const round = SkullKingPlayerRound();
          for (var field in SkullKingRoundField.values) {
            expect(round.getValue(field), 0);
          }
        },
      );
      test(
        'Test constructor',
        () {
          const round1 = SkullKingPlayerRound(fields: {SkullKingRoundField.won: 1});
          expect(round1.getValue(SkullKingRoundField.won), 1);
          expect(round1.getValue(SkullKingRoundField.skullKing), 0);
          const round2 = SkullKingPlayerRound(
            fields: {
              SkullKingRoundField.bids: 2,
              SkullKingRoundField.pirates: 3,
            },
          );
          expect(round2.getValue(SkullKingRoundField.bids), 2);
          expect(round2.getValue(SkullKingRoundField.pirates), 3);
          expect(round2.getValue(SkullKingRoundField.skullKing), 0);
        },
      );
      test(
        'Test copy constructor',
        () {
          const round1 = SkullKingPlayerRound(fields: {SkullKingRoundField.won: 1});
          expect(round1.getValue(SkullKingRoundField.won), 1);
          expect(round1.getValue(SkullKingRoundField.skullKing), 0);
          final round2 = round1.copyWith(
            fields: {
              ...round1.fields,
              SkullKingRoundField.bids: 2,
              SkullKingRoundField.pirates: 3,
            },
          );
          expect(round2.getValue(SkullKingRoundField.won), 1);
          expect(round2.getValue(SkullKingRoundField.bids), 2);
          expect(round2.getValue(SkullKingRoundField.pirates), 3);
          expect(round2.getValue(SkullKingRoundField.skullKing), 0);
        },
      );
    },
  );
}
