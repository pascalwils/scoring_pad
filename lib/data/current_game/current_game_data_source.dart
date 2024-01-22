import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/application/game_states/game_state.dart';
import 'package:scoring_pad/data/datasource.dart';
import 'package:talker/talker.dart';

final talker = Talker();

class CurrentGameDataSource {
  Future<GameState> getCurrentGame() async {
    final box = Hive.box(currentGameBoxName);
    final gameType = box.get(GameState.gameTypeKey);
    talker.debug("Get current game.");
    return NoGameState();
  }
}

final currentGameDataSourceProvider = Provider<CurrentGameDataSource>(
      (ref) {
    return CurrentGameDataSource();
  },
);
