import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pref/pref.dart';

import '../../settings/pref_keys.dart';
import '../../settings/pref_theme.dart';
import '../../translation_support.dart';
import '../widgets/pref_color.dart';

class SettingsScreen extends StatelessWidget {
  static const String path = 'settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: PrefPage(
        children: [
          PrefTitle(
            title: Text(tr.prefTitleAppearance),
          ),
          PrefDialogButton(
            title: Text(tr.theme),
            subtitle: Text(PrefTheme.fromPreferences(context).getName(tr)),
            dialog: PrefDialog(
              title: Text(tr.theme),
              cancel: Text(tr.cancel),
              submit: Text(tr.ok),
              children: [
                PrefRadio(
                  title: Text(tr.systemTheme),
                  value: PrefTheme.system.name,
                  pref: uiThemePrefKey,
                ),
                PrefRadio(
                  title: Text(tr.lightTheme),
                  value: PrefTheme.light.name,
                  pref: uiThemePrefKey,
                ),
                PrefRadio(
                  title: Text(tr.darkTheme),
                  value: PrefTheme.dark.name,
                  pref: uiThemePrefKey,
                ),
              ],
            ),
          ),
          PrefColor(
            title: Text(tr.themeColor),
            pref: uiColorPrefKey,
          ),
        ],
      ),
    );
  }
}
