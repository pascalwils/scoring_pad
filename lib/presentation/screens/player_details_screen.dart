import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/players/players_notifier.dart';
import '../../domain/entities/player.dart';
import '../widgets/player_edition/player_edition_dialog.dart';

class PlayerDetailsScreen extends ConsumerWidget {
  static const String path = '/player-details';

  const PlayerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPlayer = ref.watch(currentPlayerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPlayer.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              var player = await _displayTextInputDialog(context, currentPlayer);
              if (player != null) {
                ref.read(playersProvider.notifier).removePlayer(currentPlayer);
                ref.read(playersProvider.notifier).addPlayer(player);
                ref.read(currentPlayerProvider.notifier).setPlayer(player);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              bool? confirm = await _showDeleteConfirmDialog(context, currentPlayer.name);
              if (confirm != null && confirm) {
                ref.read(playersProvider.notifier).removePlayer(currentPlayer);
                context.pop();
              }
            },
          ),
        ],
      ),
      body: Center(child: Text("Details")),
    );
  }

  Future<Player?> _displayTextInputDialog(BuildContext context, Player player) async {
    return showDialog<Player?>(
      context: context,
      builder: (context) => createPlayerEditionDialog(context, player),
    );
  }

  Future<bool?> _showDeleteConfirmDialog(BuildContext context, String playerName) async {
    AppLocalizations tr = AppLocalizations.of(context);
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr.deletePlayer),
          content: Text(
            tr.deletePlayerMessage(playerName),
            softWrap: true,
          ),
          actions: [
            TextButton(
              child: Text(tr.no),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(tr.yes),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}

class CurrentPlayerNotifier extends StateNotifier<Player> {
  CurrentPlayerNotifier(super.state);

  void setPlayer(Player newPlayer) {
    state = newPlayer;
  }
}

final currentPlayerProvider = StateNotifierProvider<CurrentPlayerNotifier, Player>(
  (ref) {
    return CurrentPlayerNotifier(Player(name: ""));
  },
);
