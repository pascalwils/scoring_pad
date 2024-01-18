import 'dart:collection';

import 'package:scoring_pad/domain/entities/game_category.dart';
import 'package:scoring_pad/domain/entities/game_type.dart';
import 'package:scoring_pad/presentation/game_catalog.dart';

class DefaultGameCatalog extends GameCatalog {
  final Map<GameCategory, List<GameType>> _entries = HashMap();

  DefaultGameCatalog() {
    _entries.putIfAbsent(GameCategory.Dice, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Card, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Free, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Board, () => _createBoardGames());
  }

  @override
  List<GameType> getGamesWithCategory(GameCategory category) => _entries[category]!;

  List<GameType> _createBoardGames() {
    return [
      GameType.papayoo,
      GameType.prophecy,
      GameType.skullking,
    ];
  }
}
