import 'package:flutter/material.dart';
import 'package:scoring_pad/domain/entities/game.dart';
import 'package:scoring_pad/domain/entities/game_player.dart';

import '../../infrastructure/common/bounds.dart';

abstract class GameEngine {
  void startGame(BuildContext context);
  void continueGame(BuildContext context);
  Widget? getSettingsWidget();
  Bounds<int> getPlayerNumberBounds(BuildContext context);
  Game createGame(BuildContext context, List<GamePlayer> players);
  void endGame(BuildContext context);
}
