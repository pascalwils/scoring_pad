import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/player.dart';
import '../../presentation/screens/players_selection/player_selection_screen.dart';
import '../../presentation/screens/players_selection/player_selection_state.dart';
import 'game_engine.dart';

class PapayooGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context) async {
    final Object? result = await context.push(PlayerSelectionScreen.path);
    if (result != null) {
      final players = (result as List<SelectedPlayer>).map((e) => Player(name: e.name)).toList();
      players.forEach((e) {
        print(e.name);
      });
    }
  }

  @override
  void continueGame(BuildContext context) {}
}
