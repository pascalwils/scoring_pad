import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:scoring_pad/domain/entities/game_type.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';
import 'package:scoring_pad/presentation/default_game_catalog.dart';
import 'package:scoring_pad/presentation/favorites_manager.dart';
import 'package:scoring_pad/presentation/game_catalog.dart';

import 'data/in_memory_player_repository.dart';

final getIt = GetIt.instance;

final favoritesProvider = NotifierProvider<FavoriteManager, List<GameType>>(FavoriteManager.new);
final playersProvider = FutureProvider((ref) => getIt<PlayerRepository>().getAllPlayers());

void initDependencies() {
  getIt.registerLazySingleton<PlayerRepository>(() => InMemoryPlayerRepository());
  getIt.registerSingleton<GameCatalog>(DefaultGameCatalog());
}
