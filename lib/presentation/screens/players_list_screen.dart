import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/presentation/screens/player_details_screen.dart';

import '../../domain/entities/player.dart';
import '../../data/players/players_notifier.dart';
import '../widgets/player_edition/player_edition_dialog.dart';

class PlayersListScreen extends ConsumerWidget {
  static const String path = 'players-list';

  const PlayersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final players = ref.watch(playersProvider).players;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.playersList),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView.separated(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref.read(currentPlayerProvider.notifier).setPlayer(players[index]);
              context.go('/${PlayersListScreen.path}/${PlayerDetailsScreen.path}');
            },
            child: ListTile(
              title: Text(players[index].name),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var player = await _displayTextInputDialog(context);
          if (player != null) {
            ref.read(playersProvider.notifier).addPlayer(player);
          }
        },
      ),
    );
  }

  Future<Player?> _displayTextInputDialog(BuildContext context) async {
    return showDialog<Player?>(
      context: context,
      builder: (context) => createPlayerEditionDialog(context, null),
    );
  }
}
