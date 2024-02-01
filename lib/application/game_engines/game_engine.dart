import 'package:flutter/material.dart';

import '../../infrastructure/common/bounds.dart';

abstract class GameEngine {
  void startGame(BuildContext context);
  void continueGame(BuildContext context);
  Widget? getSettingsWidget();
  Bounds<int> getPlayerNumberBounds();
}
