import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/application/game_engines/game_engine.dart';
import 'package:scoring_pad/domain/entities/game_type.dart';
import 'package:scoring_pad/presentation/screens/players_selection/player_selection_state.dart';
import 'package:talker/talker.dart';

import '../../application/game_states/game_state.dart';
import '../../domain/repositories/current_game_repository.dart';
import '../../presentation/game_catalog.dart';
import 'current_game_repository_impl.dart';

final talker = Talker();

class CurrentGameNotifier extends StateNotifier<GameState> {
  final CurrentGameRepository _repository;

  CurrentGameNotifier(this._repository) : super(const GameState()) {
    _updateState();
  }

  void setGameType(GameType entry) async {
    state = GameState(gameType: entry);
    await _repository.saveCurrentGame(state);
  }

  void setPlayers(List<SelectedPlayer> players) async {
    state = state.copyWith(players: players, status: GameStatus.started);
    await _repository.saveCurrentGame(state);
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

final currentEngineProvider = Provider<GameEngine?>((ref) {
  final gameType = ref.watch(currentGameProvider).gameType;
  if (gameType != null) {
    return ref.read(gameCatalogProvider).getGameEngine(gameType);
  }
  return null;
});
