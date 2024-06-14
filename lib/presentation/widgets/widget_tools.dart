import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../managers/current_game_manager.dart';
import '../../managers/games_manager.dart';

class WidgetTools {
  // Prevent construction of this utility class
  WidgetTools._();

  static Future<bool?> _showConfirmDialog(BuildContext context) async {
    AppLocalizations tr = AppLocalizations.of(context);
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr.warning),
          content: Text(
            tr.newGameWarningMessage,
            softWrap: true,
          ),
          actions: [
            TextButton(
              child: Text(tr.no),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(tr.yes),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> checkGameInProgress(BuildContext context, WidgetRef ref) async {
    bool create = true;
    final currentGame = ref.watch(currentGameManager);
    bool gameInProgress = currentGame.players.isNotEmpty;
    if (gameInProgress) {
      bool? ok = await _showConfirmDialog(context);
      if (ok == null || !ok) {
        create = false;
      }
    }
    if (create) {
      if (gameInProgress) {
        final game = ref.read(currentGameManager).game!;
        ref.read(gamesManager.notifier).saveGame(game);
        ref.read(currentGameManager.notifier).clear();
        ref.read(currentEngineProvider)?.endGame(context);
      }
      return true;
    }
    return false;
  }
}
