import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/standard_game.dart';
import 'standard_game_round_screen_state.dart';

class StandardGameRoundEditScreenStateNotifier extends StateNotifier<StandardGameRoundScreenState> {
  final int roundIndex;
  final StandardGame game;

  StandardGameRoundEditScreenStateNotifier(this.game, this.roundIndex) : super(_getStateFromGame(game, roundIndex));

  static StandardGameRoundScreenState _getStateFromGame(StandardGame game, int roundIndex) {
    return StandardGameRoundScreenState(
      currentPageIndex: 0,
      currentRound: roundIndex,
      parameters: game.parameters,
      players: game.players,
      scores: List.empty(),
      rounds: List.empty(),
      scoreState: ScoreWidgetState(scores: List.empty()),
    );
  }
}

final standardGameRoundEditScreenProvider =
StateNotifierProvider.autoDispose.family<StandardGameRoundEditScreenStateNotifier, StandardGameRoundScreenState, int>(
      (ref, int round) {
    final game = ref.read(currentGameManager).game;
    return StandardGameRoundEditScreenStateNotifier(game as StandardGame, round);
  },
);
