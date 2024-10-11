import 'package:flutter/material.dart';
import 'package:pref/pref.dart';

import 'pref_keys.dart';

enum PrefTheme {
  system,
  light,
  dark;

  static PrefTheme fromPreferences(BuildContext context) {
    final name = PrefService.of(context).get(uiThemePrefKey);
    return PrefTheme.values.firstWhere(
          (e) => e.name == name,
      orElse: () => PrefTheme.system,
    );
  }
}
