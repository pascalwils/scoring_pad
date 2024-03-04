import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/application/game_engines/game_engine.dart';
import 'package:scoring_pad/domain/entities/game_type.dart';
import 'package:talker/talker.dart';

import '../../application/game_states/game_state.dart';
import '../../domain/entities/game.dart';
import '../../domain/entities/game_player.dart';
import '../../domain/repositories/current_game_repository.dart';
import '../../presentation/game_catalog.dart';
import 'current_game_repository_impl.dart';

final talker = Talker();

class CurrentGameNotifier extends StateNotifier<GameState> {
  final CurrentGameRepository _repository;

  CurrentGameNotifier(this._repository) : super(GameState.initial()) {
    _updateState();
  }

  void setGameType(GameType entry) async {
    state = GameState(gameType: entry, players: []);
    await _repository.saveCurrentGame(state);
  }

  void setPlayers(List<GamePlayer> players, Game game) async {
    state = state.copyWith(players: players, game: game);
    await _repository.saveCurrentGame(state);
  }

  void clear() async {
    state = GameState.initial();
    await _repository.saveCurrentGame(state);
  }

  void updateGame(Game game) async {
    state = state.copyWith(game: game);
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
