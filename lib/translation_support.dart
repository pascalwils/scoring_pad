import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/skull_king/skull_king_game_mode.dart';
import 'models/skull_king/skull_king_rules.dart';
import 'settings/pref_theme.dart';
import 'models/game_category.dart';
import 'models/game_type.dart';

extension GameCategoryTranslation on GameCategory {
  String getTitle(AppLocalizations loc) {
    switch (this) {
      case GameCategory.Dice:
        return loc.diceGames;
      case GameCategory.Board:
        return loc.boardGames;
      case GameCategory.Card:
        return loc.cardGames;
      case GameCategory.Free:
        return loc.freeGames;
    }
  }
}

extension GameTypeTranslation on GameType {
  String getName(AppLocalizations loc) {
    switch (this) {
      case GameType.papayoo:
        return loc.papayoo;
      case GameType.prophecy:
        return loc.prophecy;
      case GameType.skullking:
        return loc.skullking;
      case GameType.take5:
        return loc.take5;
    }
  }

  Image getIcon() {
    String iconName = switch (this) {
      GameType.papayoo => "papayoo",
      GameType.prophecy => "prophecy",
      GameType.skullking => "skullking",
      GameType.take5 => "take5",
    };
    return Image.asset("assets/game-icons/$iconName.webp");
  }
}

extension PrefThemeTranslation on PrefTheme {
  String getName(AppLocalizations loc) {
    switch (this) {
      case PrefTheme.system:
        return loc.systemTheme;
      case PrefTheme.light:
        return loc.lightTheme;
      case PrefTheme.dark:
        return loc.darkTheme;
    }
  }
}

extension SkullkingGameModeTranslation on SkullKingGameMode {
  String getName(AppLocalizations loc) {
    switch (this) {
      case SkullKingGameMode.regular:
        return loc.skModeRegular;
      case SkullKingGameMode.broadsideBarrage:
        return loc.skModeBroadside;
      case SkullKingGameMode.evenKeeled:
        return loc.skModeEvenKeeled;
      case SkullKingGameMode.skipToTheBrawl:
        return loc.skModeSkipBrawl;
      case SkullKingGameMode.swiftNSalty:
        return loc.skModeSwiftNSalty;
      case SkullKingGameMode.whirlpool:
        return loc.skModeWhirpool;
    }
  }

  String getSubTitle(AppLocalizations loc) {
    switch (this) {
      case SkullKingGameMode.regular:
        return loc.skModeRegularSubTitle;
      case SkullKingGameMode.broadsideBarrage:
        return loc.skModeBroadsideSubTitle;
      case SkullKingGameMode.evenKeeled:
        return loc.skModeEvenKeeledSubTitle;
      case SkullKingGameMode.skipToTheBrawl:
        return loc.skModeSkipBrawlSubTitle;
      case SkullKingGameMode.swiftNSalty:
        return loc.skModeSwiftNSaltySubTitle;
      case SkullKingGameMode.whirlpool:
        return loc.skModeWhirpoolSubTitle;
    }
  }
}

extension SkullkingRulesTranslation on SkullKingRules {
  String getName(AppLocalizations loc) {
    switch (this) {
      case SkullKingRules.initial:
        return loc.skRulesInitial;
      case SkullKingRules.since2021:
        return loc.skRulesSince2021;
    }
  }
}
