import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/presentation/default_game_catalog.dart';

import '../domain/entities/game_category.dart';
import '../domain/entities/game_type.dart';

abstract class GameCatalog {
  List<GameType> getGamesWithCategory(GameCategory category);
}

final gameCatalogProvider = Provider<GameCatalog>(
  (ref) {
    return DefaultGameCatalog(); // or return MockA();
  },
);
