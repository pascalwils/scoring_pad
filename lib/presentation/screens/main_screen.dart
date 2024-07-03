import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/about_screen.dart';
import 'package:talker/talker.dart';

import '../../managers/current_game_manager.dart';
import '../widgets/buttons_menu.dart';
import '../widgets/default_button.dart';
import '../widgets/widget_tools.dart';
import 'game_categories_screen.dart';
import 'games_list_screen.dart';
import 'players_list_screen.dart';
import 'settings_screen.dart';

final talker = Talker();

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
            icon: const Icon(Icons.info),
            onPressed: () => context.push('/${AboutScreen.path}'),
          ),
        ],
      ),
      body: ButtonsMenu(_createEntries(tr, ref)),
    );
  }

  List<ButtonsMenuItem> _createEntries(AppLocalizations tr, WidgetRef ref) {
    final gameInProgress = ref.watch(currentGameManager).isInProgress();
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
        callback: (context) async => _onCreateButtonTap(context, ref),
      ),
    );

    entries.add(ButtonsMenuItem(
      title: tr.gamesList,
      style: StyleEnum.filledTonal,
      callback: (context) {
        context.go('/${GamesListScreen.path}');
      },
    ));
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

  void _onCreateButtonTap(BuildContext context, WidgetRef ref) async {
    bool create = await WidgetTools.checkGameInProgress(context, ref);
    if (create) {
      if (!context.mounted) {
        talker.warning("Context not mounted");
        return;
      }
      context.go(GameCategoriesScreen.path);
    }
  }
}
