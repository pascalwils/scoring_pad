import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../managers/current_game_manager.dart';
import '../../managers/favorites_manager.dart';
import '../../models/game_type.dart';
import '../../translation_support.dart';
import '../screens/game_start_screen.dart';

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
        ref.read(currentGameManager.notifier).setGameType(entry);
        context.go(GameStartScreen.path);
      },
      trailing: _buildFavoriteIcon(ref, entry),
    );
  }

  Widget _buildFavoriteIcon(WidgetRef ref, GameType entry) {
    bool isFavorite = ref.watch(favoritesManager).isFavorite(entry);
    return IconButton(
      onPressed: () {
        ref.read(favoritesManager.notifier).toggleFavorite(entry);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? const Color(0xffff7785) : null,
      ),
    );
  }
}
