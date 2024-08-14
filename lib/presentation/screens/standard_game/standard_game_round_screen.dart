import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_round_screen_state.dart';
import 'package:scoring_pad/translation_support.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/game_catalog.dart';
import '../../../models/standard_game.dart';
import '../../widgets/rules_widget.dart';
import '../../widgets/score_widget.dart';
import '../../widgets/widget_tools.dart';
import 'standard_game_player_tile.dart';
import 'standard_game_round_screen_state_provider.dart';
import 'standard_game_ui_tools.dart';

class StandardGameRoundScreen extends ConsumerWidget {
  static const String path = "/standard-game-round";

  const StandardGameRoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(standardGameRoundScreenProvider);
    final game = ref.read(currentGameManager).game as StandardGame;
    final hasRules = GameCatalog().getGameEngine(game.type)?.getRulesFilename(context) != null;
    final nextEnabled = _canEndThisRound(state);
    List<Widget> bodies = _makeBodies(context, ref, hasRules);
    return Scaffold(
      appBar: AppBar(
        title: Text(game.getGameType().getName(tr)),
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
            onPressed: nextEnabled ? () => _endGame(context, ref) : null,
            child: Icon(
              Icons.check,
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
        destinations: _makeDestinations(tr, hasRules),
      ),
      body: bodies[state.currentPageIndex],
    );
  }

  List<Widget> _makeDestinations(AppLocalizations tr, bool hasRules) {
    List<Widget> result = List.empty(growable: true);
    result.add(
      NavigationDestination(
        selectedIcon: const Icon(Icons.list),
        icon: const Icon(Icons.list_outlined),
        label: tr.rounds,
      ),
    );
    result.add(
      NavigationDestination(
        selectedIcon: const Icon(Icons.scoreboard),
        icon: const Icon(Icons.scoreboard_outlined),
        label: tr.scoreboard,
      ),
    );
    if (hasRules) {
      result.add(
        NavigationDestination(
          selectedIcon: const Icon(Icons.gavel),
          icon: const Icon(Icons.gavel_outlined),
          label: tr.rules,
        ),
      );
    }
    return result;
  }

  List<Widget> _makeBodies(BuildContext context, WidgetRef ref, bool hasRules) {
    List<Widget> result = List.empty(growable: true);
    result.add(_buildListPage(context, ref));
    result.add(_buildScoreboardPage(context, ref));
    if (hasRules) {
      result.add(_buildRulesPage(ref));
    }
    return result;
  }

  Widget _buildListPage(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(standardGameRoundScreenProvider);
    final nextEnabled = _canEndThisRound(state);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(tr.roundNumber(state.currentRound + 1), style: textStyle),
              Text(tr.roundTotal(state.roundTotal), style: textStyle),
              TextButton(
                onPressed: nextEnabled ? () => WidgetTools.showNextRoundDialog(context, ref, _nextRound) : null,
                child: const Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.players.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return StandardGamePlayerTile(
                state: state.players[itemIndex],
                callback: (newScore) {
                  ref.read(standardGameRoundScreenProvider.notifier).updateRoundScore(itemIndex, newScore);
                },
                remainder: state.remainder,
              );
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

  bool _canEndThisRound(StandardGameRoundScreenState state) {
    return !state.parameters.maxScoreDefined || (state.roundTotal == state.parameters.maxScore);
  }

  void _nextRound(WidgetRef ref) {
    final game = ref.read(currentGameManager).game as StandardGame;
    final state = ref.watch(standardGameRoundScreenProvider);
    final updatedGame = StandardGameUiTools.updateGameFromState(game: game, state: state);
    ref.read(currentGameManager.notifier).updateGame(updatedGame);
    ref.read(standardGameRoundScreenProvider.notifier).update(updatedGame);
  }

  void _endGame(BuildContext context, WidgetRef ref) {
    final game = ref.read(currentGameManager).game as StandardGame;
    final state = ref.watch(standardGameRoundScreenProvider);
    final updatedGame = StandardGameUiTools.updateGameFromState(game: game, state: state);
    ref.read(currentGameManager.notifier).updateGame(updatedGame);
    ref.read(currentEngineProvider)!.endGame(context);
  }
}
