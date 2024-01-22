import 'package:flutter/cupertino.dart';
import 'package:pref/pref.dart';

import 'settings_keys.dart';

enum PrefTheme {
  system,
  light,
  dark;

  static PrefTheme fromPreferences(BuildContext context) {
    final name = PrefService.of(context).get(uiThemeSettingsKey);
    return PrefTheme.values.firstWhere(
          (e) => e.name == name,
      orElse: () => PrefTheme.system,
    );
  }
}
