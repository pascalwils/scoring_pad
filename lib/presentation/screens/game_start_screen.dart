import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/models/game_catalog.dart';
import 'package:scoring_pad/models/game_type.dart';
import 'package:scoring_pad/presentation/screens/rules_screen.dart';

import '../../models/game_state.dart';
import '../../managers/current_game_manager.dart';
import '../../translation_support.dart';
import '../widgets/buttons_menu.dart';
import '../widgets/default_button.dart';
import 'game_settings/game_settings_screen.dart';
import 'players_selection/player_selection_screen.dart';
import 'game_categories_screen.dart';

class GameStartScreen extends ConsumerWidget {
  static const String path = '/game-start-screen';
  static const int defaultMin = 2;
  static const int defaultMax = 8;

  const GameStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);

    GameState state = ref.read(currentGameManager);

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
    if (_hasRules(context, state.gameType)) {
      entries.add(ButtonsMenuItem(title: tr.rules, style: StyleEnum.filledTonal, callback: _onRules));
    }

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

  bool _hasRules(BuildContext context, GameType? gameType) {
    return gameType != null && GameCatalog().getGameEngine(gameType)?.getRulesFilename(context) != null;
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

  void _onRules(BuildContext context) {
    context.go('${GameStartScreen.path}/${RulesScreen.path}');
  }
}
