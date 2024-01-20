import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/favorites/favorite_notifier.dart';
import '../../domain/entities/game_type.dart';
import '../../translation_support.dart';
import '../game_catalog.dart';

class GameListTile extends ConsumerWidget {
  final GameType entry;

  const GameListTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    return ListTile(
      title: Text(entry.getName(tr)),
      leading: entry.getIcon(),
      onTap: () {
        final engine = ref.read(gameCatalogProvider).getGameEngine(entry);
        if (engine != null) {
          engine.startGame(context);
        }
      },
      trailing: _buildFavoriteIcon(ref, entry),
    );
  }

  Widget _buildFavoriteIcon(WidgetRef ref, GameType entry) {
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
  }
}
