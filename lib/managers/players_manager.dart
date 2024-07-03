import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:talker/talker.dart';

import '../../models/player.dart';
import '../data/datasource.dart';

final talker = Talker();

class PlayersManager extends StateNotifier<List<Player>> {
  PlayersManager() : super([]) {
    _load();
  }

  Future<void> addPlayer(Player player) async {
    try {
      if (!state.contains(player)) {
        state = [...state, player];
        final box = Hive.box(playerBoxName);
        box.put(player.name, 0);
        talker.debug("Add player ${player.name} to database.");
      }
    } catch (e) {
      talker.error("Unable to add player '${player.name}' to database", e);
      rethrow;
    }
  }

  Future<void> removePlayer(Player player) async {
    try {
      final newState = List<Player>.from(state);
      if (newState.remove(player)) {
        state = newState;
        final box = Hive.box(playerBoxName);
        box.delete(player.name);
        talker.debug("remove player ${player.name} from database.");
      }
    } catch (e) {
      talker.error("Unable to remove player '${player.name}' from database", e);
      rethrow;
    }
  }

  Future<void> _load() async {
    try {
      final box = Hive.box(playerBoxName);
      state = box.keys.map((e) => Player(name: e.toString())).toList();
    } catch (e) {
      talker.error("Unable to get all players from database", e);
      rethrow;
    }
  }
}

final playersManager = StateNotifierProvider<PlayersManager, List<Player>>(
  (ref) => PlayersManager(),
);
