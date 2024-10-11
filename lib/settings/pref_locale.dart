import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pref/pref.dart';

import 'pref_keys.dart';

enum PrefLocale {
  english, french;

  const PrefLocale();

  static PrefLocale fromPreferences(BuildContext context) {
    final index = PrefService.of(context).get<int>(localePrefKey);
    return PrefLocale.values[index ?? 0];
  }

  static PrefLocale fromCurrentLocale() {
    final locale = Platform.localeName;
    if (locale.contains("fr")) {
      return PrefLocale.french;
    }
    return PrefLocale.english;
  }

  Locale getLocale() {
    return AppLocalizations.supportedLocales[getId()];
  }

  String getTranslation(AppLocalizations loc) {
    switch(this) {
      case PrefLocale.english:
        return loc.languageEnglish;
      case PrefLocale.french:
        return loc.languageFrench;
    }
  }

  int getId() {
    return PrefLocale.values.indexOf(this);
  }
}
