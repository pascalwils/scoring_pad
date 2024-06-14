import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_score_calculator.dart';
import 'skull_king_score_screen_state.dart';

class SkullKingScoreScreenStateNotifier extends StateNotifier<SkullKingScoreScreenState> {
  SkullKingScoreScreenStateNotifier(SkullKingGame game) : super(_getStateFromGame(game));

  void update(SkullKingGame game) {
    state = _getStateFromGame(game);
  }

  static SkullKingScoreScreenState _getStateFromGame(SkullKingGame game) {
    final currentRound = game.currentRound;
    final calculator = getSkullKingScoreCalculator(game.parameters.rules);
    final playerScores = List<SkullKingPlayerScore>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      final scores = List<int>.empty(growable: true);
      for (int j = 0; j < currentRound; j++) {
        scores.add(calculator.getScore(game: game, playerIndex: i, toRoundIndex: j));
      }
      playerScores.add(SkullKingPlayerScore(player: game.players[i], scores: scores));
    }
    playerScores.sort((s1, s2) => s2.scores.last.compareTo(s1.scores.last));
    return SkullKingScoreScreenState(scores: playerScores);
  }
}

final skullKingScoreScreenProvider =
    StateNotifierProvider.autoDispose<SkullKingScoreScreenStateNotifier, SkullKingScoreScreenState>(
  (ref) {
    final game = ref.read(currentGameManager).game;
    return SkullKingScoreScreenStateNotifier(game as SkullKingGame);
  },
);
