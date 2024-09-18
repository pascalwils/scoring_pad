import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/models/player.dart';
import 'package:talker/talker.dart';

import '../data/datasource.dart';
import '../models/game.dart';

final talker = Talker();

class GamesManager extends StateNotifier<List<Game>> {
  final List<Game> _removedGames = List<Game>.empty(growable: true);

  GamesManager() : super(List.empty()) {
    _load();
  }

  void removeGames(List<Game> gamesToRemove) {
    _removedGames.clear();
    final games = List<Game>.of(state);
    final box = Hive.box(gamesBoxName);
    for (Game g in gamesToRemove) {
      int index = games.indexOf(g);
      if (index >= 0) {
        try {
          box.delete(g.getKey());
          _removedGames.add(g);
          games.removeAt(index);
        } catch (e) {
          talker.error("Unable to delete removed game from database", e);
        }
      }
    }
    talker.debug("${_removedGames.length} game(s) removed");
    state = games;
  }

  void undoRemove() {
    if (_removedGames.isNotEmpty) {
      final games = List<Game>.of(state);
      final box = Hive.box(gamesBoxName);
      for (Game g in _removedGames) {
        try {
          box.put(g.getKey(), g);
          games.add(g);
        } catch (e) {
          talker.error("Unable to put back removed game in database", e);
          rethrow;
        }
      }

      talker.debug("Game removable undone");

      _removedGames.clear();

      games.sort((a, b) => a.compareTo(b));
      state = games;
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
      talker.error("Unable to save the game to database", e);
      rethrow;
    }
  }

  void renamePlayer(Player currentPlayer, Player player) {
    try {
      final box = Hive.box(gamesBoxName);
      final List<Game> newState = List.empty(growable: true);
      for (final game in state) {
        if (game.getPlayers().contains(currentPlayer)) {
          Game newGame = game
              .setPlayers(game.getPlayers().map((it) => it.name == currentPlayer.name ? Player(name: player.name) : it).toList());
          box.put(newGame.getKey(), game);
          newState.add(newGame);
        } else {
          newState.add(game);
        }
      }
      state = newState;
    } catch (e) {
      talker.error("Unable to rename player in database", e);
      rethrow;
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
    } catch (e) {
      talker.error("Unable to get games from database", e);
      rethrow;
    }
  }
}

final gamesManager = StateNotifierProvider<GamesManager, List<Game>>(
  (ref) {
    return GamesManager();
  },
);
