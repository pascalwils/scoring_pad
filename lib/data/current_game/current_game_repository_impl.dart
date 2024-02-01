import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/game_states/game_state.dart';
import '../../domain/repositories/current_game_repository.dart';
import 'current_game_data_source.dart';

class CurrentGameRepositoryImpl implements CurrentGameRepository {
  final CurrentGameDataSource dataSource;

  CurrentGameRepositoryImpl(this.dataSource);

  @override
  Future<GameState> getCurrentGame() => dataSource.getCurrentGame();

  @override
  Future<void> saveCurrentGame(GameState currentGame) async {
    dataSource.saveCurrentGame(currentGame);
  }
}

final currentGameRepositoryProvider = Provider<CurrentGameRepository>(
      (ref) {
    final dataSource = ref.read(currentGameDataSourceProvider);
    return CurrentGameRepositoryImpl(dataSource);
  },
);
