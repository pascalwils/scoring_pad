import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/models/game_catalog.dart';
import 'package:talker/talker.dart';

import '../data/datasource.dart';
import '../game_engines/game_engine.dart';
import '../models/game_type.dart';
import '../models/game.dart';
import '../models/game_state.dart';
import '../models/game_player.dart';
import '../presentation/screens/game_start_screen.dart';

final talker = Talker();

class CurrentGameManager extends StateNotifier<GameState> {
  static const KEY = "gameKey";

  CurrentGameManager() : super(const GameState(players: [])) {
    _load();
  }

  void goToStartScreen(BuildContext context, GameType entry) async {
    state = GameState(gameType: entry, players: []);
    await _save();
    context.go(GameStartScreen.path);
  }

  void startGame(List<GamePlayer> players, Game game) async {
    state = state.copyWith(players: players, game: game);
    await _save();
  }

  void continueGame(Game game) async {
    int colorIndex = 0;
    final players = game.getPlayers().map((it) => GamePlayer(name: it.name, colorIndex: colorIndex++)).toList();
    state = GameState(gameType: game.getGameType(), players: players, game: game);
    await _save();
  }

  void clear() async {
    state = const GameState(players: []);
    await _save();
  }

  void updateGame(Game game) async {
    state = state.copyWith(game: game);
    await _save();
  }

  void _load() async {
    try {
      talker.debug("Get current game.");
      final box = Hive.box(currentGameBoxName);
      state = box.get(KEY, defaultValue: const GameState(players: []));
    } catch (e) {
      talker.error("Unable to get current game from database", e);
      rethrow;
    }
  }

  Future<void> _save() async {
    try {
      final box = Hive.box(currentGameBoxName);
      box.put(KEY, state);
      talker.debug("Current game has been saved.");
    } catch (e) {
      talker.error("Unable to save current game to database", e);
      rethrow;
    }
  }
}

final currentGameManager = StateNotifierProvider<CurrentGameManager, GameState>(
  (ref) {
    return CurrentGameManager();
  },
);

final currentEngineProvider = Provider<GameEngine?>((ref) {
  final gameType = ref.watch(currentGameManager).gameType;
  if (gameType != null) {
    return GameCatalog().getGameEngine(gameType);
  }
  return null;
});
