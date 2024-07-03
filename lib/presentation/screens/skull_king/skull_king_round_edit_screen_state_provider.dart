import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/widgets/score_widget_state.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_player_round.dart';
import '../../../models/skull_king/skull_king_score_calculator.dart';
import 'skull_king_round_screen_state.dart';
import 'skull_king_ui_tools.dart';

class SkullKingRoundEditScreenStateNotifier extends StateNotifier<SkullKingRoundScreenState> {
  final int roundIndex;
  final SkullKingGame game;

  SkullKingRoundEditScreenStateNotifier(this.game, this.roundIndex) : super(_getStateFromGame(game, roundIndex));

  void updateRound(int playerIndex, SkullKingPlayerRound round) {
    var copyRounds = List<SkullKingPlayerRound>.from(state.rounds);
    copyRounds[playerIndex] = round;
    state = state.copyWith(rounds: copyRounds);
  }

  static SkullKingRoundScreenState _getStateFromGame(SkullKingGame game, int roundIndex) {
    final calculator = getSkullKingScoreCalculator(game.parameters);
    final scores = List<int>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      scores.add(calculator.getScore(game: game, playerIndex: i, toRoundIndex: roundIndex));
    }
    final rounds = game.playerGames.map((it) => it.rounds[roundIndex]).toList();
    return SkullKingRoundScreenState(
      currentPageIndex: 0,
      currentRound: roundIndex,
      nbCards: game.nbCards(roundIndex: roundIndex),
      nbRounds: game.nbRounds(),
      parameters: game.parameters,
      players: game.players,
      scores: scores,
      rounds: rounds,
      initialRounds: rounds,
      scoreState: ScoreWidgetState(scores: List.empty()),
    );
  }
}

final skullKingRoundEditScreenProvider =
    StateNotifierProvider.autoDispose.family<SkullKingRoundEditScreenStateNotifier, SkullKingRoundScreenState, int>(
  (ref, int round) {
    final game = ref.read(currentGameManager).game;
    return SkullKingRoundEditScreenStateNotifier(game as SkullKingGame, round);
  },
);
