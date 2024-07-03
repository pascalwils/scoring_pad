import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/game_player.dart';

part 'score_widget_state.freezed.dart';

@freezed
class PlayerScore with _$PlayerScore {
  const factory PlayerScore({
    required GamePlayer player,
    required List<int> scores,
  }) = _PlayerScore;
}

@freezed
class ScoreWidgetState with _$ScoreWidgetState {
  const factory ScoreWidgetState({
    required List<PlayerScore> scores,
  }) = _ScoreWidgetState;
}
