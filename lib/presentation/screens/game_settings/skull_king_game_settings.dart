import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/skull_king/skull_king_game_mode.dart';
import '../../../models/skull_king/skull_king_rules.dart';
import '../../../settings/pref_keys.dart';
import '../../../translation_support.dart';

class SkullkingGameSettings extends StatelessWidget {
  const SkullkingGameSettings({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    return PrefPage(
      children: [
        PrefTitle(
          title: Text(tr.gameSettings),
        ),
        PrefDialogButton(
          title: Text(tr.skGameMode),
          subtitle: Text(SkullKingGameMode.fromPreferences(context).getName(tr)),
          dialog: PrefDialog(
            cancel: Text(tr.cancel),
            submit: Text(tr.ok),
            children: [
              for (final val in SkullKingGameMode.values)
                PrefRadio(
                  title: Text(val.getName(tr)),
                  subtitle: Text(val.getSubTitle(tr)),
                  value: val.name,
                  pref: skModePrefKey,
                ),
            ],
          ),
        ),
        PrefDialogButton(
          title: Text(tr.skRules),
          subtitle: Text(SkullKingRules.fromPreferences(context).getName(tr)),
          dialog: PrefDialog(
            cancel: Text(tr.cancel),
            submit: Text(tr.ok),
            title: Text(tr.skRules),
            children: [
              for (final val in SkullKingRules.values)
                PrefRadio(
                  title: Text(val.getName(tr)),
                  value: val.name,
                  pref: skRulesPrefKey,
                ),
            ],
          ),
        ),
        PrefHiderGeneric<String>(
          nullValue: SkullKingRules.initial.name,
          pref: skRulesPrefKey,
          children: [
            PrefTitle(
              title: Text(tr.cardsSettings),
            ),
            PrefSwitch(
              title: Text(tr.skLootCards),
              switchActiveColor: Theme.of(context).colorScheme.primary,
              pref: skLootCardsPrefKey,
            ),
            PrefSwitch(
              title: Text(tr.skAdvancedPirateAbilities),
              switchActiveColor: Theme.of(context).colorScheme.primary,
              pref: skAdvancedPiratesPrefKey,
            ),
            PrefTitle(
              title: Text(tr.scoreSettings),
            ),
            PrefSwitch(
              title: Text(tr.skAdditionalBonuses),
              switchActiveColor: Theme.of(context).colorScheme.primary,
              pref: skAdditionalBonusesPrefKey,
            ),
            PrefSwitch(
              title: Text(tr.skRascalScoreMode),
              switchActiveColor: Theme.of(context).colorScheme.primary,
              pref: skRascalScoreMode,
            ),
            PrefHiderGeneric<bool>(
              nullValue: false,
              pref: skRascalScoreMode,
              children: [
                PrefSwitch(
                  title: Text(tr.skRascalCannonball),
                  switchActiveColor: Theme.of(context).colorScheme.primary,
                  pref: skRascalCannonball,
                ),
              ],
            ),
          ],
        ),
        PrefTitle(
          title: Text(tr.appearance),
        ),
        PrefSwitch(
          title: Text(tr.skEmojiBonusTypes),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: skEmojiForBonusTypes,
        ),
      ],
    );
  }
}
