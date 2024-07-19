import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/managers/current_game_manager.dart';
import 'package:scoring_pad/models/game_type.dart';

import '../../models/game_category.dart';
import '../../translation_support.dart';
import 'favorite_games_screen.dart';
import 'games_screen.dart';

class GameCategoriesScreen extends ConsumerWidget {
  static String path = "/game_categories";

  const GameCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);

    final List<_Entry> entries = [
      _FavoritesEntry(tr),
      //_CategoryEntry(iconName: "dices", translation: tr, category: GameCategory.Dice),
      //_CategoryEntry(iconName: "cards", translation: tr, category: GameCategory.Card),
      _CategoryEntry(iconName: "board-game", translation: tr, category: GameCategory.board),
      _FreeGameEntry(tr),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.gameCategories),
        leading: TextButton(
          onPressed: () => context.go('/'),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          _Entry entry = entries[index];
          return ListTile(
            title: Text(entry.title),
            leading: Image.asset("assets/icons/${entry.iconName}.webp"),
            onTap: () => entry.callback(context, ref),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

abstract class _Entry {
  final String iconName;
  final String title;

  _Entry({required this.iconName, required this.title});

  void callback(BuildContext context, WidgetRef ref);
}

class _CategoryEntry extends _Entry {
  final String category;

  _CategoryEntry({required super.iconName, required AppLocalizations translation, required GameCategory category})
      : category = category.name,
        super(title: category.getTitle(translation));

  @override
  void callback(BuildContext context, WidgetRef _) {
    context.go('${GameCategoriesScreen.path}/${GamesScreen.path}/$category');
  }
}

class _FavoritesEntry extends _Entry {
  _FavoritesEntry(AppLocalizations tr) : super(iconName: "favorite", title: tr.favoriteGames);

  @override
  void callback(BuildContext context, WidgetRef _) {
    context.go('${GameCategoriesScreen.path}/${FavoriteGamesScreen.path}');
  }
}

class _FreeGameEntry extends _Entry {
  _FreeGameEntry(AppLocalizations tr) : super(iconName: "free-game", title: tr.freeGame);

  @override
  void callback(BuildContext context, WidgetRef ref) {
    ref.read(currentGameManager.notifier).goToStartScreen(context, GameType.free);
  }
}
