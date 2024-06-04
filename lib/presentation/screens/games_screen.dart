import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../translation_support.dart';
import '../../models/game_category.dart';
import '../widgets/game_list_tile.dart';
import '../../models/game_catalog.dart';

class GamesScreen extends ConsumerWidget {
  static const String path = "games";

  final GameCategory category;

  const GamesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final entries = GameCatalog().getGamesWithCategory(category);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.getTitle(tr)),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          final entry = entries[index];
          return GameListTile(entry: entry);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
