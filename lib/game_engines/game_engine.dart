import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_player.dart';
import '../common/bounds.dart';

abstract class GameEngine {
  void startGame(BuildContext context, WidgetRef ref, List<GamePlayer> players);

  void continueGame(BuildContext context, WidgetRef ref);

  Widget? getSettingsWidget();

  Bounds<int> getPlayerNumberBounds(BuildContext context);

  void endGame(BuildContext context);
}
