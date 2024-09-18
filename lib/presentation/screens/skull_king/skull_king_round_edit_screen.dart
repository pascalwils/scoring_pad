import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_round_field.dart';
import 'skull_king_round_edit_screen_state_provider.dart';
import 'skull_king_player_tile.dart';
import '../../../managers/current_game_manager.dart';
import 'skull_king_round_screen_state.dart';
import 'skull_king_ui_tools.dart';

class SkullKingRoundEditScreen extends ConsumerWidget {
  static const String path = "skull-king-round-edit";
  final int roundIndex;

  const SkullKingRoundEditScreen({super.key, required this.roundIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final state = ref.watch(skullKingRoundEditScreenProvider(roundIndex));
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.skullking),
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
              final game = ref.read(currentGameManager).game as SkullKingGame;
              final updatedGame = SkullKingUiTools.updateGameFromState(game: game, state: state, roundIndex: roundIndex);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(tr.editRound(state.currentRound + 1), style: textStyle),
              Text(tr.tricks(state.nbWon), style: textStyle),
            ],
          ),
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
      ]),
    );
  }

  void _updateField(WidgetRef ref, SkullKingRoundScreenState state, int playerIndex, SkullKingRoundField field, int newValue) {
    var round = state.rounds[playerIndex];
    round = round.copyWith(fields: {...round.fields, field: newValue});
    ref.read(skullKingRoundEditScreenProvider(roundIndex).notifier).updateRound(playerIndex, round);
  }

  void _updateRascalCannonball(WidgetRef ref, SkullKingRoundScreenState state, int playerIndex, bool cannonball) {
    var round = state.rounds[playerIndex];
    round = round.copyWith(cannonball: cannonball);
    ref.read(skullKingRoundEditScreenProvider(roundIndex).notifier).updateRound(playerIndex, round);
  }
}
