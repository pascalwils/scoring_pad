import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../models/game_player.dart';
import '../../../models/standard_game_parameters.dart';

part 'standard_game_round_screen_state.freezed.dart';

@freezed
class StandardGameRoundScreenState with _$StandardGameRoundScreenState {
  const factory StandardGameRoundScreenState({
    required int currentPageIndex,
    required int currentRound,
    required StandardGameParameters parameters,
    required List<GamePlayer> players,
    required List<int> scores,
    required List<List<int>> rounds,
    required ScoreWidgetState scoreState,
  }) = _StandardGameRoundScreenState;
}
