import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:talker/talker.dart';

import '../data/datasource.dart';
import '../models/game.dart';

final talker = Talker();

class GamesManager extends StateNotifier<List<Game>> {
  Game? _removedGame;

  GamesManager() : super(List.empty()) {
    _load();
  }

  void removeGame(Game game) {
    final games  = List<Game>.of(state);
    int index = games.indexWhere((it) => it.getKey() == game.getKey());
    if(index >= 0) {
      _removedGame = game;
      games.removeAt(index);
      state = games;
      final box = Hive.box(gamesBoxName);
      box.delete(game.getKey());
      talker.debug("Game removed");
    }
  }

  void undoRemove() {
    if (_removedGame != null) {
      var games = [...state, _removedGame!];
      games.sort((a, b) => a.compareTo(b));
      state = games;
      final box = Hive.box(gamesBoxName);
      box.put(_removedGame!.getKey(), _removedGame!);
      _removedGame = null;
      talker.debug("Game removable undone");
    }
  }

  void saveGame(Game game) {
    try {
      final key = game.getKey();
      final box = Hive.box(gamesBoxName);
      if (box.containsKey(key)) {
        int index = state.indexWhere((it) => it.getKey() == key);
        talker.debug("Game already in database at index $index.");
        state[index] = game;
      } else {
        talker.debug("New game saved with key $key.");
        var games = [...state, game];
        games.sort((a, b) => a.compareTo(b));
        state = games;
      }
      box.put(key, game);
      talker.debug("Games list has been saved.");
    } catch (e) {
      talker.debug("Unable to save the game to database", e);
    }
  }

  void _load() async {
    try {
      talker.debug("Load games list.");
      final box = Hive.box(gamesBoxName);
      final keys = box.keys.toList();
      talker.debug("Games keys : $keys");
      final games = box.values.map((it) => it as Game).toList();
      games.sort((a, b) => a.compareTo(b));
      state = games;
      } catch (e)
      {
        talker.debug("Unable to get games from database", e);
      }
    }
}

final gamesManager = StateNotifierProvider<GamesManager, List<Game>>(
      (ref) {
    return GamesManager();
  },
);
