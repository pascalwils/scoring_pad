import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/players_selection/player_selection_screen.dart';
import 'game_engine.dart';

class SkullkingGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context) {
    context.push(PlayerSelectionScreen.path);
  }

  @override
  void continueGame(BuildContext context) {
    // TODO: implement continueGame
  }
}
