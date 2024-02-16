import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'domain/entities/skullking/skullking_game_mode.dart';
import 'domain/entities/skullking/skullking_game.dart';
import 'infrastructure/settings/pref_theme.dart';
import 'domain/entities/game_category.dart';
import 'domain/entities/game_type.dart';

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

extension SkullkingGameModeTranslation on SkullkingGameMode {
  String getName(AppLocalizations loc) {
    switch (this) {
      case SkullkingGameMode.regular:
        return loc.skModeRegular;
      case SkullkingGameMode.broadsideBarrage:
        return loc.skModeBroadside;
      case SkullkingGameMode.evenKeeled:
        return loc.skModeEvenKeeled;
      case SkullkingGameMode.skipToTheBrawl:
        return loc.skModeSkipBrawl;
      case SkullkingGameMode.swiftNSalty:
        return loc.skModeSwiftNSalty;
      case SkullkingGameMode.whirlpool:
        return loc.skModeWhirpool;
    }
  }

  String getSubTitle(AppLocalizations loc) {
    switch (this) {
      case SkullkingGameMode.regular:
        return loc.skModeRegularSubTitle;
      case SkullkingGameMode.broadsideBarrage:
        return loc.skModeBroadsideSubTitle;
      case SkullkingGameMode.evenKeeled:
        return loc.skModeEvenKeeledSubTitle;
      case SkullkingGameMode.skipToTheBrawl:
        return loc.skModeSkipBrawlSubTitle;
      case SkullkingGameMode.swiftNSalty:
        return loc.skModeSwiftNSaltySubTitle;
      case SkullkingGameMode.whirlpool:
        return loc.skModeWhirpoolSubTitle;
    }
  }
}

extension SkullkingRulesTranslation on SkullkingRules {
  String getName(AppLocalizations loc) {
    switch (this) {
      case SkullkingRules.initial:
        return loc.skRulesInitial;
      case SkullkingRules.since2021:
        return loc.skRulesSince2021;
    }
  }
}
