import 'package:hive_flutter/adapters.dart';
import 'package:scoring_pad/models/skull_king/skull_king_rules.dart';

import '../models/player.dart';
import '../models/game_state.dart';
import '../models/game_player.dart';
import '../models/game_type.dart';
import '../models/skull_king/skull_king_game.dart';
import '../models/skull_king/skull_king_player_game.dart';
import '../models/skull_king/skull_king_player_round.dart';
import '../models/skull_king/skull_king_round_field.dart';
import '../models/skull_king/skull_king_game_mode.dart';
import '../models/skull_king/skull_king_game_parameters.dart';

const String favoriteBoxName = "favorites";
const String playerBoxName = "players";
const String currentGameBoxName = "currentGame";
const String gamesBoxName = "games";

Future<void> initDatasource() async {
  await Hive.initFlutter();

  Hive.registerAdapter(GamePlayerAdapter());
  Hive.registerAdapter(GameTypeAdapter());
  Hive.registerAdapter(GameStateAdapter());
  Hive.registerAdapter(PlayerAdapter());

  Hive.registerAdapter(SkullKingGameAdapter());
  Hive.registerAdapter(SkullKingPlayerRoundAdapter());
  Hive.registerAdapter(SkullKingPlayerGameAdapter());
  Hive.registerAdapter(SkullKingRoundFieldAdapter());
  Hive.registerAdapter(SkullKingGameModeAdapter());
  Hive.registerAdapter(SkullKingParametersAdapter());
  Hive.registerAdapter(SkullKingRulesAdapter());

  await Hive.openBox(favoriteBoxName);
  await Hive.openBox(playerBoxName);
  await Hive.openBox(currentGameBoxName);
  await Hive.openBox(gamesBoxName);
}
