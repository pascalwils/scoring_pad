import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'skullking_player_tile.dart';
import 'skullking_round_state.dart';
import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../data/current_game/current_game_notifier.dart';

class SkullkingRoundScreen extends ConsumerWidget {
  static const String path = "/skullking-round";

  const SkullkingRoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final players = ref.watch(currentGameProvider).players;
    final game = ref.watch(currentGameProvider).game as SkullkingGame;
    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
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
          _buildUndoActionButton(context, ref, game, tr),
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.scoreboard,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          _buildNextOrEndActionButton(context, ref, game),
        ],
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(4),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(tr.roundOnTotal(game.currentRound + 1, game.nbRounds()), style: textStyle),
            Text(tr.cards(game.nbCards()), style: textStyle),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return SkullkingPlayerTile(
                player: players[itemIndex],
                playerIndex: itemIndex,
                game: game,
                roundIndex: game.currentRound,
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildUndoActionButton(BuildContext context, WidgetRef ref, SkullkingGame game, AppLocalizations tr) {
    if (game.currentRound > 0) {
      final items = List<int>.generate(game.currentRound, (index) => index);
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Icon(
            Icons.undo,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          items: [
            ...items.map(
              (e) => DropdownMenuItem<int>(
                value: e,
                child: Text(
                  tr.roundNumber(e + 1),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ),
          ],
          onChanged: (value) {
            print("Selected round $value");
          },
          dropdownStyleData: const DropdownStyleData(
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 6),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 12,
      );
    }
  }

  Widget _buildNextOrEndActionButton(BuildContext context, WidgetRef ref, SkullkingGame game) {
    if (game.currentRound + 1 < game.nbRounds()) {
      return TextButton(
        onPressed: () {
          ref.read(currentGameProvider.notifier).updateGame(game.copyWith(currentRound: game.currentRound + 1));
        },
        child: Icon(
          Icons.navigate_next,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      );
    } else {
      return TextButton(
        onPressed: () {},
        child: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      );
    }
  }
}

class _Field {
  final int maximal;
  final int step;
  final SkullkingField field;

  const _Field({required this.maximal, this.step = 1, required this.field});
}
