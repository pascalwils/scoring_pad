import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pref/pref.dart';

import '../../../domain/entities/game_player.dart';
import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../domain/entities/skullking/skullking_score_calculator.dart';
import '../../../infrastructure/settings/pref_keys.dart';
import '../../graphic_tools.dart';
import '../../palettes.dart';
import '../../widgets/expandable.dart';
import '../../widgets/integer_field.dart';

class SkullkingPlayerTile extends ConsumerWidget {
  final GamePlayer player;
  final int playerIndex;
  final SkullkingGame game;
  final int roundIndex;

  const SkullkingPlayerTile(
      {super.key, required this.player, required this.playerIndex, required this.game, required this.roundIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);

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
            _buildPointsLine(tr, playerIndex, game, normalTextStyle, boldTextStyle),
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

  Widget _buildPointsLine(
      AppLocalizations tr, int playerIndex, SkullkingGame game, TextStyle normalTextStyle, TextStyle boldTextStyle) {
    return Row(
      children: [
        Text(
          getSkullkingScoreCalculator(game.rules)
              .getScore(
                game: game,
                playerIndex: playerIndex,
                toRoundIndex: roundIndex  - 1,
              )
              .toString(),
          style: boldTextStyle,
        ),
        const SizedBox(width: 4),
        Text(
          tr.pointsAbbr,
          style: normalTextStyle,
        ),
      ],
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
            minValue: -90,
            maxValue: 90,
            step: 10,
          ),
        );
      }
    }
    return result;
  }
}
