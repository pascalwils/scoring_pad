import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';
import 'package:scoring_pad/translation_support.dart';

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
        PrefTitle(
          title: Text(tr.cardsSettings),
        ),
        PrefSwitch(
          title: Text(tr.skLootCards),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: skLootCardsPrefKey,
        ),
        PrefSwitch(
          title: Text(tr.skMermaidCards),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: skMermaidCardsPrefKey,
        ),
        PrefTitle(
          title: Text(tr.scoreSettings),
        ),
        PrefSwitch(
          title: Text(tr.skAdvancedPirateAbilities),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: skAdvancedPiratesPrefKey,
        ),
        PrefSwitch(
          title: Text(tr.skRascalMode),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: skRascalScorePrefKey,
        ),
      ],
    );
  }
}
