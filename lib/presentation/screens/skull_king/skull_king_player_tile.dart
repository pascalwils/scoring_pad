import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pref/pref.dart';

import '../../../models/skull_king/skull_king_game.dart';
import '../../../models/skull_king/skull_king_game_parameters.dart';
import '../../../models/skull_king/skull_king_player_round.dart';
import '../../../models/skull_king/skull_king_round_field.dart';
import '../../../models/skull_king/skull_king_rules.dart';
import '../../../settings/pref_keys.dart';
import '../../graphic_tools.dart';
import '../../palettes.dart';
import '../../widgets/expandable.dart';
import '../../widgets/integer_field.dart';
import 'skull_king_round_screen_state.dart';

class SkullKingPlayerTile extends StatelessWidget {
  final SkullKingRoundScreenState state;
  final int playerIndex;
  final void Function(SkullKingRoundField, int) onFieldChange;
  final Map<SkullKingRoundField, _FieldDefinition> _fields = {};

  SkullKingPlayerTile({
    super.key,
    required this.state,
    required this.playerIndex,
    required this.onFieldChange,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    _initFields(tr);

    final player = state.players[playerIndex];
    final round = state.rounds[playerIndex];
    final initialRound = state.initialRounds?[playerIndex];

    final scheme = getColorScheme(Theme.of(context).brightness, player.colorIndex);
    final normalTextStyle = TextStyle(color: computeColorForText(scheme.text), fontSize: 16);
    final oldTextStyle = TextStyle(color: computeDimmedColorForText(scheme.text), fontSize: 16);
    final boldTextStyle = normalTextStyle.copyWith(fontWeight: FontWeight.bold);
    final bonusTextStyle = normalTextStyle.copyWith(color: scheme.base, fontWeight: FontWeight.bold);
    final useEmoji = PrefService.of(context).get<bool>(skEmojiForBonusTypes) ?? false;

    return Padding(
      padding: const EdgeInsets.all(4),
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
            _buildPointsLine(tr, normalTextStyle, boldTextStyle, state.scores[playerIndex]),
          ]),
          subtitle: Column(
            children: [
              _buildField(
                  SkullKingRoundField.bids, round, initialRound, normalTextStyle, oldTextStyle, scheme, useEmoji, state.nbCards),
              _buildField(
                  SkullKingRoundField.won, round, initialRound, normalTextStyle, oldTextStyle, scheme, useEmoji, state.nbCards),
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
                    children:
                        _buildBonusLines(normalTextStyle, oldTextStyle, scheme, useEmoji, round, initialRound, state.parameters),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initFields(AppLocalizations tr) {
    if (_fields.isEmpty) {
      _fields[SkullKingRoundField.bids] = _FieldDefinition(standardText: tr.skBid, maxValue: 0);
      _fields[SkullKingRoundField.won] = _FieldDefinition(standardText: tr.skTricksWon, maxValue: 0);
      _fields[SkullKingRoundField.pirates] = _FieldDefinition(
          standardText: tr.skPiratesCaptured, emojiText: tr.skPiratesCapturedEmoji, maxValue: SkullKingGame.nbPirates);
      _fields[SkullKingRoundField.skullKing] =
          _FieldDefinition(standardText: tr.skSkullKingCaptured, emojiText: tr.skSkullKingCapturedEmoji, maxValue: 1);
      _fields[SkullKingRoundField.standard14] =
          _FieldDefinition(standardText: tr.skStandard14s, emojiText: tr.skStandard14sEmoji, maxValue: SkullKingGame.nbStandard14s);
      _fields[SkullKingRoundField.black14] =
          _FieldDefinition(standardText: tr.skBlack14, emojiText: tr.skBlack14Emoji, maxValue: 1);
      _fields[SkullKingRoundField.mermaids] = _FieldDefinition(
          standardText: tr.skMermaidsCaptured, emojiText: tr.skMermaidsCapturedEmoji, maxValue: SkullKingGame.nbMermaids);
      _fields[SkullKingRoundField.loots] =
          _FieldDefinition(standardText: tr.skLootEarned, emojiText: tr.skLootEarnedEmoji, maxValue: SkullKingGame.nbLoots);
      _fields[SkullKingRoundField.rascalBid] = _FieldDefinition(standardText: tr.skRascalBid, maxValue: 20, step: 10);
      _fields[SkullKingRoundField.bonuses] =
          _FieldDefinition(standardText: tr.skAdditionalBonuses, minValue: -90, maxValue: 90, step: 10);
    }
  }

  Widget _buildPointsLine(AppLocalizations tr, TextStyle normalTextStyle, TextStyle boldTextStyle, int score) {
    return Row(
      children: [
        Text(
          score.toString(),
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

  List<Widget> _buildBonusLines(
    TextStyle style,
    TextStyle oldStyle,
    PlayerColorScheme scheme,
    bool useEmoji,
    SkullKingPlayerRound round,
    SkullKingPlayerRound? initialRound,
    SkullKingGameParameters parameters,
  ) {
    List<Widget> result = List<Widget>.empty(growable: true);
    result.add(_buildField(SkullKingRoundField.pirates, round, initialRound, style, oldStyle, scheme, useEmoji, null));
    result.add(_buildField(SkullKingRoundField.skullKing, round, initialRound, style, oldStyle, scheme, useEmoji, null));
    if (parameters.rules == SkullKingRules.since2021) {
      result.add(_buildField(SkullKingRoundField.standard14, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      result.add(_buildField(SkullKingRoundField.black14, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      result.add(_buildField(SkullKingRoundField.mermaids, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      if (parameters.lootCardsPresent) {
        result.add(_buildField(SkullKingRoundField.loots, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      }
      if (parameters.advancedPirateAbilitiesEnabled) {
        result.add(_buildField(SkullKingRoundField.rascalBid, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      }
      if (parameters.additionalBonusesEnabled) {
        result.add(_buildField(SkullKingRoundField.bonuses, round, initialRound, style, oldStyle, scheme, useEmoji, null));
      }
    }
    return result;
  }

  IntegerField _buildField(
    SkullKingRoundField field,
    SkullKingPlayerRound round,
    SkullKingPlayerRound? initialRound,
    TextStyle style,
    TextStyle oldStyle,
    PlayerColorScheme scheme,
    bool useEmoji,
    int? maxValue,
  ) {
    _FieldDefinition def = _fields[field]!;
    return IntegerField(
      text: useEmoji ? def.emojiText ?? def.standardText : def.standardText,
      value: round.getValue(field),
      oldValue: initialRound?.getValue(field),
      style: style,
      oldValueStyle: oldStyle,
      buttonBackground: scheme.buttonBackground,
      minValue: def.minValue,
      maxValue: maxValue ?? def.maxValue,
      step: def.step,
      onChange: (int newValue) {
        onFieldChange(field, newValue);
      },
    );
  }
}

class _FieldDefinition {
  final String standardText;
  final String? emojiText;
  final int minValue;
  final int maxValue;
  final int step;

  _FieldDefinition({
    required this.standardText,
    this.emojiText,
    this.minValue = 0,
    required this.maxValue,
    this.step = 1,
  });
}
