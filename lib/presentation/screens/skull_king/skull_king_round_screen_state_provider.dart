import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/screens/skull_king/skull_king_ui_tools.dart';
import 'package:talker/talker.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_player_round.dart';
import '../../../models/skull_king/skull_king_score_calculator.dart';
import 'skull_king_round_screen_state.dart';

final talker = Talker();

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

  void updatePageIndex(int index) {
    state = state.copyWith(currentPageIndex: index);
  }

  static SkullKingRoundScreenState _getStateFromGame(SkullKingGame game) {
    final currentRound = game.currentRound;
    talker.debug("Update Skull-king round screen for round #$currentRound");
    final calculator = getSkullKingScoreCalculator(game.parameters);
    final scores = List<int>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      scores.add(calculator.getScore(game: game, playerIndex: i, toRoundIndex: currentRound - 1));
    }
    final rounds = game.playerGames.map((it) => it.rounds[currentRound]).toList();
    return SkullKingRoundScreenState(
      currentPageIndex: 0,
      currentRound: currentRound,
      nbCards: game.nbCards(),
      nbRounds: game.nbRounds(),
      parameters: game.parameters,
      players: game.players,
      scores: scores,
      rounds: rounds,
      scoreState: SkullKingUiTools.getScoreStateFromGame(game),
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
