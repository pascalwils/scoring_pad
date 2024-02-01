import 'package:hive_flutter/adapters.dart';
import 'package:scoring_pad/data/adapters/selected_player_adapter.dart';
import 'package:scoring_pad/presentation/screens/players_selection/player_selection_state.dart';

const String favoriteBoxName = "favorites";
const String playerBoxName = "players";
const String currentGameBoxName = "currentGame";

Future<void> initDatasource() async {
  await Hive.initFlutter();

  Hive.registerAdapter<SelectedPlayer>(SelectedPlayerAdapter());

  await Hive.openBox(favoriteBoxName);
  await Hive.openBox(playerBoxName);
  await Hive.openBox(currentGameBoxName);
}
