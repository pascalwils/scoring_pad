import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_category.dart';
import 'game_type.dart';
import '../game_engines/game_engine.dart';
import '../game_engines/papayoo_game_engine.dart';
import '../game_engines/skull_king_game_engine.dart';

class GameCatalog {
  static final GameCatalog _instance = GameCatalog._internal();
  final Map<GameCategory, List<GameType>> _entries = HashMap();
  final Map<GameType, GameEngine> _engines = HashMap();

  factory GameCatalog() {
    return _instance;
  }

  GameCatalog._internal() {
    //_entries.putIfAbsent(GameCategory.Dice, () => List<GameType>.empty());
    //_entries.putIfAbsent(GameCategory.Card, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.free, () => List<GameType>.empty());
    _entries.putIfAbsent(GameCategory.board, () => _createBoardGames());

    // _engines.putIfAbsent(GameType.papayoo, () => PapayooGameEngine());
    _engines.putIfAbsent(GameType.skullking, () => SkullKingGameEngine());
  }

  List<GameType> getGamesWithCategory(GameCategory category) => _entries[category]!;

  GameEngine? getGameEngine(GameType type) => _engines[type];

  List<GameType> _createBoardGames() {
    return [
      // GameType.papayoo,
      // GameType.prophecy,
      GameType.skullking,
      // GameType.take5,
    ];
  }
}
