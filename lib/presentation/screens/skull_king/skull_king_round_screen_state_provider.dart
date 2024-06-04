import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_player_round.dart';
import '../../../models/skull_king/skull_king_score_calculator.dart';
import 'skull_king_round_screen_state.dart';

class SkullKingRoundScreenStateNotifier extends StateNotifier<SkullKingRoundScreenState> {
  SkullKingRoundScreenStateNotifier(SkullKingGame game) : super(_getStateFromGame(game));

  void update(SkullKingGame game) {
    state = _getStateFromGame(game);
  }

  void updateRound(int playerIndex, SkullKingPlayerRound round) {
    var copyRounds = List<SkullKingPlayerRound>.from(state.rounds);
    copyRounds[playerIndex] = round;
    state = state.copyWith(rounds: copyRounds);
  }

  static SkullKingRoundScreenState _getStateFromGame(SkullKingGame game) {
    final currentRound = game.currentRound;
    final calculator = getSkullKingScoreCalculator(game.parameters.rules);
    final scores = List<int>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      scores.add(calculator.getScore(game: game, playerIndex: i, toRoundIndex: currentRound - 1));
    }
    final rounds = game.playerGames.map((it) => it.rounds[currentRound]).toList();
    return SkullKingRoundScreenState(
      currentRound: currentRound,
      nbCards: game.nbCards(),
      nbRounds: game.nbRounds(),
      parameters: game.parameters,
      players: game.players,
      scores: scores,
      rounds: rounds,
    );
  }
}

final skullKingRoundScreenProvider =
    StateNotifierProvider.autoDispose<SkullKingRoundScreenStateNotifier, SkullKingRoundScreenState>(
  (ref) {
    final game = ref.read(currentGameManager).game;
    return SkullKingRoundScreenStateNotifier(game as SkullKingGame);
  },
);
