import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/current_game/current_game_notifier.dart';
import '../../application/game_states/game_state.dart';
import 'games_screen.dart';
import 'players_list_screen.dart';
import 'settings_screen.dart';
import '../widgets/default_button.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double buttonWidth = 250;
    const double buttonSpacing = 20;

    AppLocalizations tr = AppLocalizations.of(context);

    GameState gameState = ref.watch(currentGameProvider);

    List<_MenuEntry> entries = List.empty(growable: true);
    if (gameState is! NoGameState) {
      entries.add(_MenuEntry(title: tr.continueGame, path: "", style: StyleEnum.filled));
    }
    entries.add(_MenuEntry(
      title: tr.createNewGame,
      path: GamesScreen.path,
      style: gameState is! NoGameState ? StyleEnum.filledTonal : StyleEnum.filled,
    ));
    entries.add(_MenuEntry(title: tr.gamesList, path: "", style: StyleEnum.filledTonal));
    entries.add(_MenuEntry(title: tr.playersList, path: PlayersListScreen.path, style: StyleEnum.filledTonal));
    entries.add(_MenuEntry(title: tr.settings, path: SettingsScreen.path, style: StyleEnum.outlined));

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
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: buttonSpacing,
          children: [
            for (final entry in entries)
              SizedBox(
                width: buttonWidth,
                child: DefaultButton(
                  onPressed: () => context.push(entry.path),
                  label: entry.title,
                  styleEnum: entry.style,
                ),
              )
          ],
        ),
      ),
    );
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

class _MenuEntry {
  final String title;
  final String path;
  final StyleEnum style;

  _MenuEntry({required this.title, required this.path, required this.style});
}
