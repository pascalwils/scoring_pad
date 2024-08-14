import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/standard_game.dart';
import 'standard_game_player_round_state.dart';
import 'standard_game_round_screen_state.dart';
import 'standard_game_ui_tools.dart';

class StandardGameRoundEditScreenStateNotifier extends StateNotifier<StandardGameRoundScreenState> {
  final int roundIndex;
  final StandardGame game;

  StandardGameRoundEditScreenStateNotifier(this.game, this.roundIndex) : super(_getStateFromGame(game, roundIndex));

  void updateRoundScore(int playerIndex, int newScore) {}

  static StandardGameRoundScreenState _getStateFromGame(StandardGame game, int roundIndex) {
    talker.debug("Update Standard game round screen for round #$roundIndex");
    return StandardGameUiTools.getStateFromGame(game, roundIndex);
  }
}

final standardGameRoundEditScreenProvider =
    StateNotifierProvider.autoDispose.family<StandardGameRoundEditScreenStateNotifier, StandardGameRoundScreenState, int>(
  (ref, int roundIndex) {
    final game = ref.read(currentGameManager).game;
    return StandardGameRoundEditScreenStateNotifier(game as StandardGame, roundIndex);
  },
);
