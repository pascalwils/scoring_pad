import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/game_catalog.dart';
import '../../../models/standard_game.dart';
import '../../widgets/rules_widget.dart';
import '../../widgets/score_widget.dart';
import '../../widgets/widget_tools.dart';
import 'standard_game_round_screen_state_provider.dart';
import 'standard_game_ui_tools.dart';

class StandardGameRoundScreen extends ConsumerWidget {
  static const String path = "/standard-game-round";

  const StandardGameRoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(standardGameRoundScreenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.skullking),
        leading: TextButton(
          onPressed: () => context.go('/'),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        actions: [
          StandardGameUiTools.buildUndoActionButton(context, state.currentRound, tr, (StandardGame? updatedGame) {
            if (updatedGame != null) {
              ref.read(standardGameRoundScreenProvider.notifier).update(updatedGame);
            }
          }),
          TextButton(
            onPressed: () => WidgetTools.showNextRoundDialog(context, ref, _nextRound),
            child: Icon(
              Icons.navigate_next,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          ref.read(standardGameRoundScreenProvider.notifier).updatePageIndex(index);
        },
        selectedIndex: state.currentPageIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.list),
            icon: const Icon(Icons.list_outlined),
            label: tr.skBid,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.scoreboard),
            icon: const Icon(Icons.scoreboard_outlined),
            label: tr.scoreboard,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.gavel),
            icon: const Icon(Icons.gavel_outlined),
            label: tr.rules,
          ),
        ],
      ),
      body: [
        _buildListPage(context, ref),
        _buildScoreboardPage(context, ref),
        _buildRulesPage(ref),
      ][state.currentPageIndex],
    );
  }

  Widget _buildListPage(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(standardGameRoundScreenProvider);
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(tr.roundNumber(state.currentRound + 1), style: textStyle),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.rounds.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return const Placeholder();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScoreboardPage(BuildContext context, WidgetRef ref) {
    final state = ref.watch(standardGameRoundScreenProvider);
    return ScoreWidget(state: state.scoreState);
  }

  Widget _buildRulesPage(WidgetRef ref) {
    final game = ref.read(currentGameManager).game as StandardGame;
    return RulesWidget(gameEngine: GameCatalog().getGameEngine(game.getGameType()));
  }

  void _nextRound(WidgetRef ref) {
    final game = ref.read(currentGameManager).game as StandardGame;
    final state = ref.watch(standardGameRoundScreenProvider);
    final updatedGame = StandardGameUiTools.updateGameFromState(game: game, state: state);
    ref.read(currentGameManager.notifier).updateGame(updatedGame);
    ref.read(standardGameRoundScreenProvider.notifier).update(updatedGame);
  }
}
