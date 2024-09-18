import 'package:flutter/material.dart';
import 'package:pref/pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/settings/pref_keys.dart';

class FreeGameSettings extends StatelessWidget {
  const FreeGameSettings({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    return PrefPage(
      children: [
        PrefTitle(
          title: Text(tr.gameSettings),
        ),
        PrefSwitch(
          title: Text(tr.fgHighScoreWin),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: fgHighScoreWin,
        ),
        PrefSwitch(
          title: Text(tr.fgMaxScoreDefined),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: fgMaxScoreDefined,
        ),
        PrefHiderGeneric<bool>(
          nullValue: false,
          pref: fgMaxScoreDefined,
          children: [
            PrefIntegerText(label: tr.fgMaxScore, pref: fgMaxScore),
          ],
        ),
        PrefSwitch(
          title: Text(tr.fgAllowNegativeScore),
          switchActiveColor: Theme.of(context).colorScheme.primary,
          pref: fgAllowNegativeScore,
        ),
      ],
    );
  }
}
