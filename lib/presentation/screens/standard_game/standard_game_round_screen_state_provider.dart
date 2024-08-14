import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_player_round_state.dart';
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

  void updateRoundScore(int playerIndex, int newScore) {
    final players = List<StandardGamePlayerRoundState>.from(state.players);
    final clampedScore = state.parameters.authorizedNegativeScore ? newScore : max(0, newScore);
    players[playerIndex] = state.players[playerIndex].copyWith(roundScore: clampedScore);
    final tempState = state.copyWith(players: players);
    final int total = tempState.players.map((it) => it.roundScore).fold(0, (a, b) => a + b);
    if (state.parameters.maxScoreDefined) {
      final int remainder = state.parameters.maxScore - total;
      state = tempState.copyWith(remainder: remainder, roundTotal: total);
    } else {
      state = tempState.copyWith(remainder: null, roundTotal: total);
    }
  }

  static StandardGameRoundScreenState _getStateFromGame(StandardGame game) {
    talker.debug("Update Standard game round screen for round #${game.currentRound}");
    return StandardGameUiTools.getStateFromGame(game, game.currentRound);
  }
}

final standardGameRoundScreenProvider =
    StateNotifierProvider.autoDispose<StandardGameRoundScreenStateNotifier, StandardGameRoundScreenState>(
  (ref) {
    final game = ref.read(currentGameManager).game;
    return StandardGameRoundScreenStateNotifier(game as StandardGame);
  },
);
