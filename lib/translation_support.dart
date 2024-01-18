import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        return "take5";
      case GameType.defaultGame:
        return "";
    }
  }

  Image getIcon() {
    String iconName = switch (this) {
      GameType.papayoo => "papayoo",
      GameType.prophecy => "prophecy",
      GameType.skullking => "skullking",
      GameType.take5 => "take5",
      _ => "",
    };
    return Image.asset("assets/game-icons/$iconName.webp");
  }
}
