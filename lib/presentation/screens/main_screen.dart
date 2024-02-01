import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/game_states/game_state.dart';
import '../../data/current_game/current_game_notifier.dart';
import '../widgets/buttons_menu.dart';
import 'game_categories_screen.dart';
import 'players_list_screen.dart';
import 'settings_screen.dart';
import '../widgets/default_button.dart';

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
      body: ButtonsMenu(
        _createEntries(
          tr,
          ref.watch(currentGameProvider).status == GameStatus.started,
        ),
      ),
    );
  }

  List<ButtonsMenuItem> _createEntries(AppLocalizations tr, bool gameInProgress) {
    List<ButtonsMenuItem> entries = List.empty(growable: true);
    if (gameInProgress) {
      entries.add(ButtonsMenuItem(title: tr.continueGame, style: StyleEnum.filled, callback: (_) {}));
    }
    entries.add(ButtonsMenuItem(
      title: tr.createNewGame,
      style: gameInProgress ? StyleEnum.filledTonal : StyleEnum.filled,
      callback: (context) {
        context.go(GameCategoriesScreen.path);
      },
    ));
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
}
