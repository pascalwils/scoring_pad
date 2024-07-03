import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/screens/skull_king/skull_king_ui_tools.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_score_calculator.dart';
import '../../widgets/score_widget_state.dart';

class SkullKingScoreScreenStateNotifier extends StateNotifier<ScoreWidgetState> {
  SkullKingScoreScreenStateNotifier(SkullKingGame game) : super(SkullKingUiTools.getScoreStateFromGame(game));

  void update(SkullKingGame game) {
    state = SkullKingUiTools.getScoreStateFromGame(game);
  }
}

final skullKingScoreScreenProvider = StateNotifierProvider.autoDispose<SkullKingScoreScreenStateNotifier, ScoreWidgetState>(
  (ref) {
    final game = ref.read(currentGameManager).game;
    return SkullKingScoreScreenStateNotifier(game as SkullKingGame);
  },
);
