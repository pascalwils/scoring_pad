import 'package:scoring_pad/application/game_states/game_state.dart';

import '../entities/game_type.dart';

abstract class CurrentGameRepository {
  Future<GameState> getCurrentGame();

  Future<void> saveCurrentGame(GameState state);
}
