import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../managers/current_game_manager.dart';
import '../../managers/games_manager.dart';
import '../../models/game.dart';

class WidgetTools {
  // Prevent construction of this utility class
  WidgetTools._();

  static Future<bool?> _showConfirmDialog(BuildContext context, String text) async {
    AppLocalizations tr = AppLocalizations.of(context);
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr.warning),
          content: Text(text, softWrap: true),
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
    AppLocalizations tr = AppLocalizations.of(context);
    bool create = true;
    final gameInProgress = ref.watch(currentGameManager).isInProgress();
    if (gameInProgress) {
      bool? ok = await _showConfirmDialog(context, tr.newGameWarningMessage);
      if (ok == null || !ok) {
        create = false;
      }
    }
    if (create) {
      if (gameInProgress) {
        if (!context.mounted) {
          return false;
        }
        final game = ref.read(currentGameManager).game!;
        ref.read(gamesManager.notifier).saveGame(game);
        ref.read(currentGameManager.notifier).clear();
        ref.read(currentEngineProvider)?.endGame(context);
      }
      return true;
    }
    return false;
  }

  static Future<bool> checkInProgress(BuildContext context, WidgetRef ref, List<Game> games) async {
    AppLocalizations tr = AppLocalizations.of(context);
    bool result = true;
    final gameInProgress = games.contains(ref.watch(currentGameManager).game);
    if (gameInProgress) {
      bool? ok = await _showConfirmDialog(context, tr.deleteCurrentInProgressGame);
      if (ok == null || !ok) {
        result = false;
      }
      if (result) {
        if (!context.mounted) {
          return false;
        }
        // Clear current game
        ref.read(currentGameManager.notifier).clear();
        ref.read(currentEngineProvider)?.endGame(context);
      }
    }
    return result;
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required List<Widget> content,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        AppLocalizations tr = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: content,
            ),
          ),
          actions: [
            TextButton(
              child: Text(tr.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showNextRoundDialog(BuildContext context, WidgetRef ref, void Function(WidgetRef) nextRound) {
    AppLocalizations tr = AppLocalizations.of(context);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(tr.cancel),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: Text(tr.nextRound),
      onPressed: () {
        Navigator.of(context).pop();
        nextRound(ref);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(tr.startNextRoundTitle),
      content: Text(tr.startNextRoundText),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showEndGameDialog(BuildContext context, WidgetRef ref, void Function(BuildContext, WidgetRef) endGame) {
    AppLocalizations tr = AppLocalizations.of(context);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(tr.cancel),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: Text(tr.endGame),
      onPressed: () {
        Navigator.of(context).pop();
        endGame(context, ref);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(tr.endGameTitle),
      content: Text(tr.endGameText),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
