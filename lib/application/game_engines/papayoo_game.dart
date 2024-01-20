import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/players_selection/players_selection_screen.dart';
import 'game_engine.dart';

class PapayooGameEngine extends GameEngine {
  @override
  void startGame(BuildContext context) {
    context.push(PlayersSelectionScreen.path);
  }

  @override
  void continueGame(BuildContext context) {}
}
