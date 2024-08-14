import 'package:freezed_annotation/freezed_annotation.dart';

part 'standard_game_player_round_state.freezed.dart';

@freezed
class StandardGamePlayerRoundState with _$StandardGamePlayerRoundState {
  const factory StandardGamePlayerRoundState({
    required String name,
    required int colorIndex,
    required int totalScore,
    required int roundScore,
  }) = _StandardGamePlayerRoundState;
}
