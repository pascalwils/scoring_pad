import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker/talker.dart';

import '../../application/game_states/game_state.dart';
import '../../domain/entities/game.dart';
import '../datasource.dart';
import '../../domain/entities/game_player.dart';
import '../../domain/entities/game_type.dart';

final talker = Talker();

class CurrentGameDataSource {
  Future<GameState> getCurrentGame() async {
    final box = Hive.box(currentGameBoxName);
    final GameType? gameType = GameType.fromString(box.get(GameState.gameTypeKey, defaultValue: ""));
    final List<GamePlayer> players = List<GamePlayer>.from(box.get(GameState.playersKey, defaultValue: []));
    final Game game = box.get(GameState.gameKey);
    talker.debug("Get current game.");
    return GameState(gameType: gameType, players: players, game: game);
  }

  Future<void> saveCurrentGame(GameState currentGame) async {
    final box = Hive.box(currentGameBoxName);
    box.put(GameState.gameTypeKey, currentGame.gameType?.name ?? "");
    box.put(GameState.playersKey, currentGame.players);
    box.put(GameState.gameKey, currentGame.game);
    talker.debug("Current game has been saved.");
  }
}

final currentGameDataSourceProvider = Provider<CurrentGameDataSource>(
  (ref) {
    return CurrentGameDataSource();
  },
);
