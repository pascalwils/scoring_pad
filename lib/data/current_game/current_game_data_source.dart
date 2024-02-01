import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scoring_pad/application/game_states/game_state.dart';
import 'package:scoring_pad/data/datasource.dart';
import 'package:scoring_pad/presentation/screens/players_selection/player_selection_state.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/game_type.dart';

final talker = Talker();

class CurrentGameDataSource {
  Future<GameState> getCurrentGame() async {
    final box = Hive.box(currentGameBoxName);
    final GameType? gameType = GameType.fromString(box.get(GameState.gameTypeKey, defaultValue: ""));
    final GameStatus status = GameStatus.fromString(box.get(GameState.statusKey, defaultValue: ""));
    final List<SelectedPlayer> players = List<SelectedPlayer>.from(box.get(GameState.playersKey, defaultValue: []));
    talker.debug("Get current game.");
    return GameState(gameType: gameType, status: status, players: players);
  }

  Future<void> saveCurrentGame(GameState currentGame) async {
    final box = Hive.box(currentGameBoxName);
    box.put(GameState.gameTypeKey, currentGame.gameType?.name ?? "");
    box.put(GameState.statusKey, currentGame.status.name);
    if (currentGame.players != null) {
      box.put(GameState.playersKey, currentGame.players);
    } else {
      box.delete(GameState.playersKey);
    }
    talker.debug("Current game has been saved.");
  }
}

final currentGameDataSourceProvider = Provider<CurrentGameDataSource>(
  (ref) {
    return CurrentGameDataSource();
  },
);
