import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../application/game_states/game_state.dart';
import '../../domain/repositories/current_game_repository.dart';
import 'current_game_repository_impl.dart';

final talker = Talker();

class CurrentGameNotifier extends StateNotifier<GameState> {
  final CurrentGameRepository _repository;

  CurrentGameNotifier(this._repository) : super(NoGameState()) {
    _updateState();
  }

  void _updateState() async {
    try {
      state = await _repository.getCurrentGame();
    } catch (e) {
      talker.debug("Unable to get current game from repository", e);
    }
  }
}

final currentGameProvider = StateNotifierProvider<CurrentGameNotifier, GameState>(
      (ref) {
    final repository = ref.watch(currentGameRepositoryProvider);
    return CurrentGameNotifier(repository);
  },
);
