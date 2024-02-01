import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/domain/entities/game_category.dart';
import 'package:scoring_pad/presentation/screens/favorite_games_screen.dart';
import 'package:scoring_pad/presentation/screens/games_screen.dart';
import 'package:scoring_pad/translation_support.dart';

class GameCategoriesScreen extends StatelessWidget {
  static String path = "/game_categories";

  const GameCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    final List<_Entry> entries = [
      _Entry.favorites(
        iconName: "favorite",
        title: tr.favoriteGames,
        path: '${GameCategoriesScreen.path}/${FavoriteGamesScreen.path}',
      ),
      _Entry.category(iconName: "dices", translation: tr, category: GameCategory.Dice),
      _Entry.category(iconName: "cards", translation: tr, category: GameCategory.Card),
      _Entry.category(iconName: "board-game", translation: tr, category: GameCategory.Board),
      _Entry.category(iconName: "free-game", translation: tr, category: GameCategory.Free),
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
            onTap: () {
              context.go(entry.path);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class _Entry {
  final String iconName;
  final String title;
  final String path;

  _Entry.favorites({required this.iconName, required this.title, required this.path});

  _Entry.category({required this.iconName, required AppLocalizations translation, required GameCategory category})
      : title = category.getTitle(translation),
        path = '${GameCategoriesScreen.path}/${GamesScreen.path}/${category.name}';
}
