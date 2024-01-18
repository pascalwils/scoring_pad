import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/data/datasource.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/player.dart';

final talker = Talker();

class PlayerDataSource {
  Future<bool> addPlayer(Player player) async {
    final box = Hive.box(playerBoxName);
    if (!box.containsKey(player.name)) {
      box.put(player.name, 0);
      talker.debug("Add player ${player.name} to database.");
      return true;
    }
    return false;
  }

  Future<bool> removePlayer(Player player) async {
    final box = Hive.box(playerBoxName);
    if (box.containsKey(player.name)) {
      box.delete(player.name);
      talker.debug("remove player ${player.name} from database.");
      return true;
    }
    return false;
  }

  Future<List<Player>> getAllPlayers() async {
    talker.debug("Get all players.");
    final box = Hive.box(playerBoxName);
    return box.keys.map((e) => Player(name: e.toString())).toList();
  }
}

final playerDataSourceProvider = Provider<PlayerDataSource>(
  (ref) {
    return PlayerDataSource();
  },
);
