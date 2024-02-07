import 'package:hive_flutter/adapters.dart';

import 'adapters/game_player_adapter.dart';
import 'adapters/skullking/skullking_game_adapter.dart';
import 'adapters/skullking/skullking_player_round_adapter.dart';

const String favoriteBoxName = "favorites";
const String playerBoxName = "players";
const String currentGameBoxName = "currentGame";

Future<void> initDatasource() async {
  await Hive.initFlutter();

  Hive.registerAdapter(GamePlayerAdapter());
  Hive.registerAdapter(SkullkingGameAdapter());
  Hive.registerAdapter(SkullkingPlayerRoundAdapter());

  await Hive.openBox(favoriteBoxName);
  await Hive.openBox(playerBoxName);
  await Hive.openBox(currentGameBoxName);
}
