import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/widgets/game_list_tile.dart';

import '../../data/favorites/favorite_notifier.dart';

class FavoriteGamesScreen extends StatelessWidget {
  static const String path = "favorite-games";

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
              return GameListTile(entry: entry);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        },
      ),
    );
  }
}
