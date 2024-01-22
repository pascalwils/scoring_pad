import 'package:hive_flutter/adapters.dart';

const String favoriteBoxName = "favorites";
const String playerBoxName = "players";
const String currentGameBoxName = "currentGame";

Future<void> initDatasource() async {
  await Hive.initFlutter();
  await Hive.openBox(favoriteBoxName);
  await Hive.openBox(playerBoxName);
  await Hive.openBox(currentGameBoxName);
}
