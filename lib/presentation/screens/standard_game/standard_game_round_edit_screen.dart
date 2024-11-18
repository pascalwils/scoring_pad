import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_player_tile.dart';

import '../../../translation_support.dart';
import '../../../managers/current_game_manager.dart';
import '../../../models/standard_game.dart';
import 'standard_game_round_edit_screen_state_provider.dart';
import 'standard_game_ui_tools.dart';

class StandardGameRoundEditScreen extends ConsumerWidget {
  static const String path = "standard-game-round-edit";
  final int roundIndex;

  const StandardGameRoundEditScreen({super.key, required this.roundIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(standardGameRoundEditScreenProvider(roundIndex));
    final game = ref.read(currentGameManager).game as StandardGame;
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(game.getGameType().getName(tr)),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final game = ref.read(currentGameManager).game as StandardGame;
              final updatedGame = StandardGameUiTools.updateGameFromState(game: game, state: state, roundIndex: roundIndex);
              ref.read(currentGameManager.notifier).updateGame(updatedGame);
              context.pop(updatedGame);
            },
            child: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(4),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
            child: Text(tr.editRound(state.currentRound + 1), style: textStyle),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.players.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return StandardGamePlayerTile(
                state: state.players[itemIndex],
                callback: (newScore) {
                  ref.read(standardGameRoundEditScreenProvider(roundIndex).notifier).updateRoundScore(itemIndex, newScore);
                },
                remainder: state.remainder,
              );
            },
          ),
        ),
      ]),
    );
  }
}
