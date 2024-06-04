import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../managers/current_game_manager.dart';
import '../widgets/buttons_menu.dart';
import '../widgets/default_button.dart';
import 'game_categories_screen.dart';
import 'players_list_screen.dart';
import 'settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appTitle),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: ButtonsMenu(_createEntries(tr, ref)),
    );
  }

  List<ButtonsMenuItem> _createEntries(AppLocalizations tr, WidgetRef ref) {
    final currentGame = ref.watch(currentGameManager);
    bool gameInProgress = currentGame.players.isNotEmpty;
    List<ButtonsMenuItem> entries = List.empty(growable: true);
    if (gameInProgress) {
      entries.add(ButtonsMenuItem(
          title: tr.continueGame,
          style: StyleEnum.filled,
          callback: (context) {
            ref.read(currentEngineProvider)?.continueGame(context, ref);
          }));
    }
    entries.add(
      ButtonsMenuItem(
        title: tr.createNewGame,
        style: gameInProgress ? StyleEnum.filledTonal : StyleEnum.filled,
        callback: (context) async => _onCreateButtonTap(context, gameInProgress, ref),
      ),
    );

    entries.add(ButtonsMenuItem(title: tr.gamesList, style: StyleEnum.filledTonal, callback: (_) {}));
    entries.add(ButtonsMenuItem(
      title: tr.playersList,
      style: StyleEnum.filledTonal,
      callback: (context) {
        context.go('/${PlayersListScreen.path}');
      },
    ));
    entries.add(ButtonsMenuItem(
      title: tr.settings,
      style: StyleEnum.outlined,
      callback: (context) {
        context.go('/${SettingsScreen.path}');
      },
    ));

    return entries;
  }

  void _showAboutDialog(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    showAboutDialog(
      context: context,
      applicationName: tr.appTitle,
      applicationVersion: "1.0.0",
      applicationLegalese: "(c) 2024 - Pascal WILS",
    );
  }

  Future<bool?> _showConfirmDialog(BuildContext context) async {
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

  void _onCreateButtonTap(BuildContext context, bool gameInProgress, WidgetRef ref) async {
    bool create = true;
    if (gameInProgress) {
      bool? ok = await _showConfirmDialog(context);
      if (ok == null || !ok) {
        create = false;
      }
    }
    if (create) {
      if (!context.mounted) return;
      if (gameInProgress) {
        ref.read(currentGameManager.notifier).clear();
        ref.read(currentEngineProvider)?.endGame(context);
      }
      context.go(GameCategoriesScreen.path);
    }
  }
}
