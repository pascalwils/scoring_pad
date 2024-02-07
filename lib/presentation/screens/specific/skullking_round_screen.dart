import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/expandable.dart';
import 'skullking_round_state.dart';
import '../../../domain/entities/game_player.dart';
import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../data/current_game/current_game_notifier.dart';
import '../../palettes.dart';
import '../../graphic_tools.dart';
import '../../widgets/IntegerField.dart';

class SkullkingRoundScreen extends ConsumerWidget {
  static const String path = "/skullking-round";

  const SkullkingRoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final players = ref.watch(currentGameProvider).players;
    final game = ref.watch(currentGameProvider).game as SkullkingGame;
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
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return _buildTile(players[itemIndex], game, context, tr);
        },
      ),
    );
  }

  Widget _buildTile(GamePlayer player, SkullkingGame game, BuildContext context, AppLocalizations tr) {
    final Color color = getColorPalette(Theme.of(context).brightness)[player.colorIndex];
    final Color textColor = computeColorForText(color);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Row(children: [
            Expanded(
              child: Text(
                player.name,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "0",
              style: TextStyle(color: textColor),
            ),
          ]),
          subtitle: Column(
            children: [
              _buildLine(context, tr.skBid, textColor, 0, 2),
              _buildLine(context, tr.skTricksWon, textColor, 0, 2),
              const SizedBox(height: 8),
              Expandable(
                backgroundColor: color,
                boxShadow: const [],
                arrowColor: textColor,
                firstChild: Text(
                  tr.skBonusPoints,
                  style: TextStyle(color: textColor),
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 4,
                    bottom: 6,
                  ),
                  child: Column(
                    children: _buildBonusLines(game, context, tr, textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBonusLines(SkullkingGame game, BuildContext context, AppLocalizations tr, Color textColor) {
    List<Widget> result = List<Widget>.empty(growable: true);
    result.add(_buildLine(context, tr.skStandard14sEmoji, textColor, 0, SkullkingGame.nbStandard14s));
    result.add(_buildLine(context, tr.skBlack14Emoji, textColor, 0, 1));
    if (game.mermaidCardsPresent) {
      result.add(_buildLine(context, tr.skMermaidsCapturedEmoji, textColor, 0, SkullkingGame.nbMermaids));
    }
    result.add(_buildLine(context, tr.skPiratesCapturedEmoji, textColor, 0, SkullkingGame.nbPirates));
    if (game.mermaidCardsPresent) {
      result.add(_buildLine(context, tr.skSkullKingCapturedEmoji, textColor, 0, 1));
    }
    if (game.lootCardsPresent) {
      result.add(_buildLine(context, tr.skLootEarnedEmoji, textColor, 0, SkullkingGame.nbLoots));
    }
    if (game.rascalScoringEnabled) {
      result.add(_buildLine(context, tr.skRascalBid, textColor, 0, 20, step: 10));
    }
    return result;
  }

  Widget _buildLine(BuildContext context, String text, Color textColor, int value, int maximal, {int step = 1}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text(
            "0",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          IntegerField(
            initialValue: value,
            maxValue: maximal,
            step: step,
          ),
        ],
      ),
    );
  }
}

class _Field {
  final int maximal;
  final int step;
  final SkullkingField field;

  const _Field({required this.maximal, this.step = 1, required this.field});
}
