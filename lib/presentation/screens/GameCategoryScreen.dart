import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GameCategoryScreen extends StatelessWidget {
  const GameCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    final List<_Entry> entries = [
      _Entry(title: tr.diceGames, iconName: "dices", path: "/dice-games"),
      _Entry(title: tr.cardGames, iconName: "cards", path: "/card-games"),
      _Entry(title: tr.boardGames, iconName: "board-game", path: "/board-games"),
      _Entry(title: tr.freeGame, iconName: "free-game", path: "/free-game"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appTitle),
        leading: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
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
  final String title;
  final String iconName;
  final String path;

  _Entry({required this.title, required this.iconName, required this.path});
}
