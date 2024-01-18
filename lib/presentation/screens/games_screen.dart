import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/favorites/favorite_notifier.dart';
import 'players_selection/players_selection_screen.dart';
import '../../translation_support.dart';
import '../../domain/entities/game_type.dart';
import '../../domain/entities/game_category.dart';
import '../game_catalog.dart';

class GamesScreen extends ConsumerWidget {
  static const String path = "/games";

  final GameCategory category;

  const GamesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final entries = ref.read(gameCatalogProvider).getGamesWithCategory(category);
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
          return ListTile(
            title: Text(entry.getName(tr)),
            leading: entry.getIcon(),
            onTap: () {
              context.push(PlayersSelectionScreen.path);
            },
            trailing: _buildFavoriteIcon(entry),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildFavoriteIcon(GameType entry) {
    return Consumer(
      builder: (_, ref, __) {
        bool isFavorite = ref.watch(favoritesProvider).favorites.contains(entry);
        return IconButton(
          onPressed: () {
            ref.read(favoritesProvider.notifier).toggleFavorite(entry);
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? const Color(0xffff7785) : null,
          ),
        );
      },
    );
  }
}
