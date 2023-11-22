import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class BoardGamesScreen extends StatelessWidget {
  const BoardGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    final List<_Entry> entries = [
      _Entry(title: tr.papayoo, iconName: "papayoo", path: "/papayoo"),
      _Entry(title: tr.skullking, iconName: "skullking", path: "/skullking"),
      _Entry(title: tr.prophecy, iconName: "prophetie", path: "/prophetie"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.boardGames),
        leading: TextButton(
          onPressed: () => context.go("/"),
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
            leading: Image.asset("assets/game-icons/${entry.iconName}.webp"),
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
