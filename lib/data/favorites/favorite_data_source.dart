import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/data/datasource.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/game_type.dart';

final talker = Talker();

class FavoriteDataSource {
  Future<void> toggleFavorite(GameType entry) async {
    final box = Hive.box(favoriteBoxName);
    if (!box.containsKey(entry.name)) {
      box.put(entry.name, 0);
      talker.debug("Add favorite '$entry' to database.");
    }
    else {
      box.delete(entry.name);
      talker.debug("Remove favorite '$entry' to database.");
    }
  }

  Future<List<GameType>> getAllFavorites() async {
    final box = Hive.box(favoriteBoxName);
    talker.debug("Get all favorites.");
    return box.keys.map((e) => GameType.fromString(e.toString())).toList();
  }
}

final favoriteDataSourceProvider = Provider<FavoriteDataSource>(
      (ref) {
    return FavoriteDataSource();
  },
);
