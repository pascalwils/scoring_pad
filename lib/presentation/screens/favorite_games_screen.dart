import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/players_selection/players_selection_screen.dart';
import '../../translation_support.dart';
import '../../data/favorites/favorite_notifier.dart';
import '../../domain/entities/game_type.dart';

class FavoriteGamesScreen extends StatelessWidget {
  static const String path = "/favorite-games";

  const FavoriteGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations tr = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.favoriteGames),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer(
        builder: (_, ref, __) {
          var entries = ref.watch(favoritesProvider).favorites;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              var entry = entries[index];
              return ListTile(
                title: Text(entry.getName(tr)),
                leading: entry.getIcon(),
                onTap: () {
                  context.push(PlayersSelectionScreen.path);
                },
                trailing: _buildFavoriteIcon(ref, entries, entry),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteIcon(WidgetRef ref, List<GameType> entries, GameType entry) {
    bool isFavorite = entries.contains(entry);
    return IconButton(
      onPressed: () {
        if (isFavorite) {
          ref.read(favoritesProvider.notifier).removeFavorite(entry);
        } else {
          ref.read(favoritesProvider.notifier).addFavorite(entry);
        }
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? const Color(0xffff7785) : null,
      ),
    );
  }
}
