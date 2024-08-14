import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../models/standard_game_parameters.dart';
import 'standard_game_player_round_state.dart';

part 'standard_game_round_screen_state.freezed.dart';

@freezed
class StandardGameRoundScreenState with _$StandardGameRoundScreenState {
  const factory StandardGameRoundScreenState({
    required int currentPageIndex,
    required int currentRound,
    required StandardGameParameters parameters,
    required List<StandardGamePlayerRoundState> players,
    required int roundTotal,
    int? remainder,
    required ScoreWidgetState scoreState,
  }) = _StandardGameRoundScreenState;
}
