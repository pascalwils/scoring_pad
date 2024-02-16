import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';
import 'package:scoring_pad/translation_support.dart';

import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../infrastructure/settings/pref_keys.dart';

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
          subtitle: Text(SkullkingGameMode.fromPreferences(context).getName(tr)),
          dialog: PrefDialog(
            cancel: Text(tr.cancel),
            submit: Text(tr.ok),
            children: [
              for (final val in SkullkingGameMode.values)
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
          subtitle: Text(SkullkingRules.fromPreferences(context).getName(tr)),
          dialog: PrefDialog(
            cancel: Text(tr.cancel),
            submit: Text(tr.ok),
            title: Text(tr.skRules),
            children: [
              for (final val in SkullkingRules.values)
                PrefRadio(
                  title: Text(val.getName(tr)),
                  value: val.name,
                  pref: skRulesPrefKey,
                ),
            ],
          ),
        ),
        PrefHiderGeneric<String>(
          nullValue: SkullkingRules.initial.name,
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
            PrefSwitch(
              title: Text(tr.skAdditionalBonuses),
              switchActiveColor: Theme.of(context).colorScheme.primary,
              pref: skAdditionalBonusesPrefKey,
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
