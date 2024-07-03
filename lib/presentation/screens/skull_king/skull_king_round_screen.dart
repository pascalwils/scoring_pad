import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/skull_king/skull_king_game.dart';
import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_round_field.dart';
import '../../widgets/rules_widget.dart';
import '../../widgets/score_widget.dart';
import 'skull_king_round_screen_state.dart';
import 'skull_king_round_screen_state_provider.dart';
import 'skull_king_player_tile.dart';
import 'skull_king_score_screen_state_provider.dart';
import 'skull_king_ui_tools.dart';

class SkullKingRoundScreen extends ConsumerWidget {
  static const String path = "/skull-king-round";

  const SkullKingRoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(skullKingRoundScreenProvider);
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
          SkullKingUiTools.buildUndoActionButton(context, state.currentRound, tr, (SkullKingGame? updatedGame) {
            if (updatedGame != null) {
              ref.read(skullKingRoundScreenProvider.notifier).update(updatedGame);
            }
          }),
          _buildNextOrEndActionButton(context, ref),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          ref.read(skullKingRoundScreenProvider.notifier).updatePageIndex(index);
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
            selectedIcon: const Icon(Icons.scoreboard),
            icon: const Icon(Icons.scoreboard_outlined),
            label: tr.rules,
          ),
        ],
      ),
      body: [
        _buildBidPage(context, ref),
        _buildScoreboardPage(context, ref),
        _buildRulesPage(context, ref),
      ][state.currentPageIndex],
    );
  }

  Widget _buildBidPage(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(skullKingRoundScreenProvider);
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
            Text(tr.roundOnTotal(state.currentRound + 1, state.nbRounds), style: textStyle),
            Text(tr.cards(state.nbCards), style: textStyle),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.rounds.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return SkullKingPlayerTile(
                state: state,
                playerIndex: itemIndex,
                onFieldChange: (SkullKingRoundField field, int newValue) {
                  _updateField(ref, state, itemIndex, field, newValue);
                },
                onRascalFieldChange: (cannonball) {
                  _updateRascalCannonball(ref, state, itemIndex, cannonball);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNextOrEndActionButton(BuildContext context, WidgetRef ref) {
    final game = ref.read(currentGameManager).game as SkullKingGame;
    if (game.currentRound + 1 < game.nbRounds()) {
      return TextButton(
        onPressed: () => _showNextRoundDialog(context, ref),
        child: Icon(
          Icons.navigate_next,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      );
    } else {
      return TextButton(
        onPressed: () {
          final state = ref.watch(skullKingRoundScreenProvider);
          final updatedGame = SkullKingUiTools.updateGameFromState(game: game, state: state);
          ref.read(currentGameManager.notifier).updateGame(updatedGame);
          ref.read(currentEngineProvider)!.endGame(context);
        },
        child: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      );
    }
  }

  void _showNextRoundDialog(BuildContext context, WidgetRef ref) {
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
        _nextRound(ref);
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

  void _nextRound(WidgetRef ref) {
    final game = ref.read(currentGameManager).game as SkullKingGame;
    final state = ref.watch(skullKingRoundScreenProvider);
    final updatedGame = SkullKingUiTools.updateGameFromState(game: game, state: state);
    ref.read(currentGameManager.notifier).updateGame(updatedGame);
    ref.read(skullKingRoundScreenProvider.notifier).update(updatedGame);
  }

  void _updateField(WidgetRef ref, SkullKingRoundScreenState state, int playerIndex, SkullKingRoundField field, int newValue) {
    var round = state.rounds[playerIndex];
    round = round.copyWith(fields: {...round.fields, field: newValue});
    ref.read(skullKingRoundScreenProvider.notifier).updateRound(playerIndex, round);
  }

  void _updateRascalCannonball(WidgetRef ref, SkullKingRoundScreenState state, int playerIndex, bool cannonball) {
    var round = state.rounds[playerIndex];
    round = round.copyWith(cannonball: cannonball);
    ref.read(skullKingRoundScreenProvider.notifier).updateRound(playerIndex, round);
  }

  Widget _buildScoreboardPage(BuildContext context, WidgetRef ref) {
    final state = ref.watch(skullKingRoundScreenProvider);
    return ScoreWidget(state: state.scoreState);
  }

  Widget _buildRulesPage(BuildContext context, WidgetRef ref) {
    final currentGameType = ref.read(currentGameManager).gameType;
    return RulesWidget(gameType: currentGameType!);
  }
}
