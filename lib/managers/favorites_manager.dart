import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/models/game_type.dart';
import 'package:talker/talker.dart';

import '../data/datasource.dart';
import '../models/favorites.dart';

final talker = Talker();

class FavoritesManager extends StateNotifier<Favorites> {
  FavoritesManager() : super(Favorites.empty()) {
    load();
  }

  Future<void> load() async {
    try {
      final box = Hive.box(favoriteBoxName);
      talker.debug("Get all favorites.");
      state = Favorites(entries: box.keys.map((e) => GameType.fromId(e)).toList().whereType<GameType>().toList());
    } catch (e) {
      talker.error("Cannot retrieve favorites from database", e);
      state = Favorites.empty();
    }
  }

  Future<void> toggleFavorite(GameType game) async {
    final box = Hive.box(favoriteBoxName);
    if (!state.isFavorite(game)) {
      try {
        box.put(game.id, 0);
        state = Favorites(entries: [...state.entries, game]);
        talker.debug("Add favorite '$game' to database.");
      } catch (e) {
        talker.error("Can not add favorite to database", e);
        rethrow;
      }
    } else {
      try {
        box.delete(game.id);
        final newList = List<GameType>.from(state.entries);
        newList.remove(game);
        state = Favorites(entries: newList);
        talker.debug("Remove favorite '$game' from database.");
      } catch (e) {
        talker.error("Can not remove favorite to database", e);
        rethrow;
      }
    }
  }
}

final favoritesManager = StateNotifierProvider<FavoritesManager, Favorites>((ref) {
  return FavoritesManager();
});
