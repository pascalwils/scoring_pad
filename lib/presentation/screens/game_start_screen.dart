import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:scoring_pad/application/game_states/game_state.dart';
import 'package:scoring_pad/data/current_game/current_game_notifier.dart';
import 'package:scoring_pad/presentation/screens/players_selection/player_selection_screen.dart';
import 'package:scoring_pad/translation_support.dart';

import '../widgets/buttons_menu.dart';
import '../widgets/default_button.dart';
import 'game_categories_screen.dart';
import 'game_settings_screen.dart';

class GameStartScreen extends ConsumerWidget {
  static const String path = '/game-start-screen';
  static const int defaultMin = 2;
  static const int defaultMax = 8;

  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);

    GameState state = ref.read(currentGameProvider);

    List<ButtonsMenuItem> entries = List.empty(growable: true);
    entries.add(
      ButtonsMenuItem(
        title: tr.selectPlayers,
        style: StyleEnum.filled,
        callback: (context) {
          _onSelectPlayers(context, ref);
        },
      ),
    );
    if (_getWidget(ref) != null) {
      entries.add(ButtonsMenuItem(title: tr.settings, style: StyleEnum.filledTonal, callback: _onSettings));
    }
    entries.add(ButtonsMenuItem(title: tr.rules, style: StyleEnum.filledTonal, callback: (_) {}));

    return Scaffold(
      appBar: AppBar(
        title: Text(state.gameType?.getName(tr) ?? ""),
        leading: TextButton(
          onPressed: () => context.go(GameCategoriesScreen.path),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      body: ButtonsMenu(entries),
    );
  }

  Widget? _getWidget(WidgetRef ref) {
    return ref.read(currentEngineProvider)?.getSettingsWidget();
  }

  void _onSelectPlayers(BuildContext context, WidgetRef ref) {
    final bounds = ref.read(currentEngineProvider)?.getPlayerNumberBounds(context);
    final nbMinPlayers = bounds?.min ?? defaultMin;
    final nbMaxPlayers = bounds?.max ?? defaultMax;
    context.push('${GameStartScreen.path}/${PlayerSelectionScreen.path}/$nbMinPlayers/$nbMaxPlayers');
  }

  void _onSettings(BuildContext context) {
    context.go('${GameStartScreen.path}/${GameSettingsScreen.path}');
  }
}
