import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/domain/entities/game_category.dart';
import 'package:scoring_pad/domain/entities/game_type.dart';

import '../application/game_engines/game_engine.dart';
import '../application/game_engines/papayoo_game.dart';
import '../application/game_engines/skullking_game.dart';

class GameCatalog {
  final Map<GameCategory, List<GameType>> _entries = HashMap();
  final Map<GameType, GameEngine> _engines = HashMap();

  GameCatalog() {
    _entries.putIfAbsent(GameCategory.Dice, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Card, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Free, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.Board, () => _createBoardGames());

    _engines.putIfAbsent(GameType.papayoo, () => PapayooGameEngine());
    _engines.putIfAbsent(GameType.skullking, () => SkullkingGameEngine());
  }

  List<GameType> getGamesWithCategory(GameCategory category) => _entries[category]!;

  GameEngine? getGameEngine(GameType type) => _engines[type];

  List<GameType> _createBoardGames() {
    return [
      GameType.papayoo,
      GameType.prophecy,
      GameType.skullking,
      GameType.take5,
    ];
  }
}

final gameCatalogProvider = Provider<GameCatalog>(
      (ref) {
    return GameCatalog(); // or return MockA();
  },
);
