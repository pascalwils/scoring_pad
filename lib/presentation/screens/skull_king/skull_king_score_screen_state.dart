import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/game_player.dart';

part 'skull_king_score_screen_state.freezed.dart';

@freezed
class SkullKingPlayerScore with _$SkullKingPlayerScore {
  const factory SkullKingPlayerScore({
    required GamePlayer player,
    required List<int> scores,
  }) = _SkullKingPlayerScore;
}

@freezed
class SkullKingScoreScreenState with _$SkullKingScoreScreenState {
  const factory SkullKingScoreScreenState({
    required List<SkullKingPlayerScore> scores,
  }) = _SkullKingScoreScreenState;
}
