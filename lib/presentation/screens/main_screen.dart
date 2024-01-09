import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/games_screen.dart';

import '../widgets/default_button.dart';

class MainScreen extends StatelessWidget {
  final bool gameRunning = false;

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 250;
    const double buttonSpacing = 20;

    AppLocalizations tr = AppLocalizations.of(context);

    List<_MenuEntry> entries = List.empty(growable: true);
    if (gameRunning) {
      entries.add(_MenuEntry(title: tr.continueGame, path: "", style: StyleEnum.filled));
    }
    entries.add(_MenuEntry(
      title: tr.createNewGame,
      path: GamesScreen.path,
      style: gameRunning ? StyleEnum.filledTonal : StyleEnum.filled,
    ));
    entries.add(_MenuEntry(title: tr.gamesList, path: "", style: StyleEnum.filledTonal));
    entries.add(_MenuEntry(title: tr.playersList, path: "", style: StyleEnum.filledTonal));
    entries.add(_MenuEntry(title: tr.settings, path: "", style: StyleEnum.outlined));

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
