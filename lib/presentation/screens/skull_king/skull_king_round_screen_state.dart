import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../models/game_player.dart';
import '../../../models/skull_king/skull_king_game_parameters.dart';
import '../../../models/skull_king/skull_king_player_round.dart';

part 'skull_king_round_screen_state.freezed.dart';

@freezed
class SkullKingRoundScreenState with _$SkullKingRoundScreenState {
  const factory SkullKingRoundScreenState({
    required int currentPageIndex,
    required int currentRound,
    required int nbCards,
    required int nbRounds,
    required int nbWon,
    required SkullKingGameParameters parameters,
    required List<GamePlayer> players,
    required List<int> scores,
    required List<SkullKingPlayerRound> rounds,
    required ScoreWidgetState scoreState,
    List<SkullKingPlayerRound>? initialRounds,
  }) = _SkullKingRoundScreenState;
}
