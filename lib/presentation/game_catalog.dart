import 'package:scoring_pad/domain/entities/game_category.dart';

import '../domain/entities/game_type.dart';

abstract class GameCatalog {
  List<GameType> getGamesWithCategory(GameCategory category);
}
