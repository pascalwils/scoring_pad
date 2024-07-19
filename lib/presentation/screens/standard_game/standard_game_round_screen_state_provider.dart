import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_ui_tools.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';
import 'package:talker/talker.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/standard_game.dart';
import 'standard_game_round_screen_state.dart';

final talker = Talker();

class StandardGameRoundScreenStateNotifier extends StateNotifier<StandardGameRoundScreenState> {
  StandardGameRoundScreenStateNotifier(StandardGame game) : super(_getStateFromGame(game));

  void update(StandardGame game) {
    state = _getStateFromGame(game);
  }

  void updatePageIndex(int index) {
    state = state.copyWith(currentPageIndex: index);
  }

  static StandardGameRoundScreenState _getStateFromGame(StandardGame game) {
    final currentRound = game.currentRound;
    talker.debug("Update Standard game round screen for round #$currentRound");
    return StandardGameRoundScreenState(
      currentPageIndex: 0,
      currentRound: currentRound,
      parameters: game.parameters,
      players: game.players,
      scores: List.empty(),
      rounds: List.empty(),
      scoreState: StandardGameUiTools.getScoreStateFromGame(game),
    );
  }
}

final standardGameRoundScreenProvider =
StateNotifierProvider.autoDispose<StandardGameRoundScreenStateNotifier, StandardGameRoundScreenState>(
      (ref) {
    final game = ref.read(currentGameManager).game;
    return StandardGameRoundScreenStateNotifier(game as StandardGame);
  },
);
