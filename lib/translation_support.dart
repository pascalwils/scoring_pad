import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/presentation/widgets/score_graph_widget.dart';

import 'models/skull_king/skull_king_game_mode.dart';
import 'models/skull_king/skull_king_rules.dart';
import 'settings/pref_theme.dart';
import 'models/game_category.dart';
import 'models/game_type.dart';

extension GameCategoryTranslation on GameCategory {
  String getTitle(AppLocalizations loc) {
    switch (this) {
      case GameCategory.dice:
        return loc.diceGames;
      case GameCategory.board:
        return loc.boardGames;
      case GameCategory.card:
        return loc.cardGames;
      case GameCategory.free:
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

extension GraphCurveShapeTranslation on GraphCurveShape {
  String getName(AppLocalizations loc) {
    switch (this) {
      case GraphCurveShape.curved:
        return loc.graphCurveShapeCurved;
      case GraphCurveShape.straight:
        return loc.graphCurveShapeStraight;
      case GraphCurveShape.step:
        return loc.graphCurveShapeStep;
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
