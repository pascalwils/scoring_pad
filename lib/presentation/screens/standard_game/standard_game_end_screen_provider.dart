import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/standard_game.dart';
import '../../widgets/score_widget_state.dart';
import 'standard_game_ui_tools.dart';

class StandardGameEndScreenStateNotifier extends StateNotifier<ScoreWidgetState> {
  StandardGameEndScreenStateNotifier(StandardGame game) : super(StandardGameUiTools.getScoreStateFromGame(game));

  void update(StandardGame game) {
    state = StandardGameUiTools.getScoreStateFromGame(game);
  }
}

final standardGameEndScreenProvider = StateNotifierProvider.autoDispose<StandardGameEndScreenStateNotifier, ScoreWidgetState>(
  (ref) {
    final game = ref.read(currentGameManager).game;
    return StandardGameEndScreenStateNotifier(game as StandardGame);
  },
);
