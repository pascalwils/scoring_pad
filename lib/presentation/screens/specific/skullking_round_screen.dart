import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pref/pref.dart';
import 'package:scoring_pad/infrastructure/settings/pref_keys.dart';

import '../../../domain/entities/skullking/skullking_score_calculator.dart';
import '../../widgets/expandable.dart';
import 'skullking_round_state.dart';
import '../../../domain/entities/game_player.dart';
import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../data/current_game/current_game_notifier.dart';
import '../../palettes.dart';
import '../../graphic_tools.dart';
import '../../widgets/integer_field.dart';

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
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(4),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(tr.round(game.currentRound + 1, game.nbRounds()), style: textStyle),
            Text(tr.cards(game.nbCards()), style: textStyle),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildTile(players[itemIndex], itemIndex, game, context, tr);
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildTile(GamePlayer player, int index, SkullkingGame game, BuildContext context, AppLocalizations tr) {
    final scheme = getColorScheme(Theme.of(context).brightness, player.colorIndex);
    final normalTextStyle = TextStyle(color: computeColorForText(scheme.text), fontSize: 20);
    final boldTextStyle = normalTextStyle.copyWith(fontWeight: FontWeight.bold);
    final bonusTextStyle = normalTextStyle.copyWith(color: scheme.base, fontWeight: FontWeight.bold);
    final useEmoji = PrefService.of(context).get<bool>(skEmojiForBonusTypes) ?? false;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Ink(
        decoration: BoxDecoration(
          color: scheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Row(children: [
            Expanded(
              child: Text(
                player.name,
                style: boldTextStyle,
              ),
            ),
            Text(
              getSkullkingScoreCalculator(game.rules).getScore(game.rounds[index], game.currentRound - 1).toString(),
              style: boldTextStyle,
            ),
            Text(
              " pts",
              style: normalTextStyle,
            ),
          ]),
          subtitle: Column(
            children: [
              IntegerField(
                text: tr.skBid,
                style: normalTextStyle,
                buttonBackground: scheme.buttonBackground,
                maxValue: game.nbCards(),
              ),
              IntegerField(
                text: tr.skTricksWon,
                style: normalTextStyle,
                buttonBackground: scheme.buttonBackground,
                maxValue: game.nbCards(),
              ),
              const SizedBox(height: 8),
              Expandable(
                backgroundColor: scheme.background,
                boxShadow: const [],
                arrowColor: scheme.base,
                firstChild: Text(
                  tr.skBonusPoints,
                  style: bonusTextStyle,
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 4,
                    bottom: 6,
                  ),
                  child: Column(
                    children: _buildBonusLines(game, tr, normalTextStyle, scheme, useEmoji),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBonusLines(SkullkingGame game, AppLocalizations tr, TextStyle style, PlayerColorScheme scheme, bool useEmoji) {
    List<Widget> result = List<Widget>.empty(growable: true);
    result.add(
      IntegerField(
        text: useEmoji ? tr.skPiratesCapturedEmoji : tr.skPiratesCaptured,
        style: style,
        buttonBackground: scheme.buttonBackground,
        maxValue: SkullkingGame.nbPirates,
      ),
    );
    result.add(
      IntegerField(
        text: useEmoji ? tr.skSkullKingCapturedEmoji : tr.skSkullKingCaptured,
        style: style,
        buttonBackground: scheme.buttonBackground,
        maxValue: 1,
      ),
    );
    if (game.rules == SkullkingRules.since2021) {
      result.add(
        IntegerField(
          text: useEmoji ? tr.skStandard14sEmoji : tr.skStandard14s,
          style: style,
          buttonBackground: scheme.buttonBackground,
          maxValue: SkullkingGame.nbStandard14s,
        ),
      );
      result.add(
        IntegerField(
          text: useEmoji ? tr.skBlack14Emoji : tr.skBlack14,
          style: style,
          buttonBackground: scheme.buttonBackground,
          maxValue: 1,
        ),
      );
      result.add(
        IntegerField(
          text: useEmoji ? tr.skMermaidsCapturedEmoji : tr.skMermaidsCaptured,
          style: style,
          buttonBackground: scheme.buttonBackground,
          maxValue: SkullkingGame.nbMermaids,
        ),
      );
      if (game.lootCardsPresent) {
        result.add(
          IntegerField(
            text: useEmoji ? tr.skLootEarnedEmoji : tr.skLootEarned,
            style: style,
            buttonBackground: scheme.buttonBackground,
            maxValue: SkullkingGame.nbLoots,
          ),
        );
      }
      if (game.advancedPirateAbilitiesEnabled) {
        result.add(
          IntegerField(
            text: tr.skRascalBid,
            style: style,
            buttonBackground: scheme.buttonBackground,
            maxValue: 20,
            step: 10,
          ),
        );
      }
      if (game.additionalBonuses) {
        result.add(
          IntegerField(
            text: tr.skAdditionalBonuses,
            style: style,
            buttonBackground: scheme.buttonBackground,
            minValue: -100,
            maxValue: 100,
            step: 10,
          ),
        );
      }
    }
    return result;
  }
}

class _Field {
  final int maximal;
  final int step;
  final SkullkingField field;

  const _Field({required this.maximal, this.step = 1, required this.field});
}
