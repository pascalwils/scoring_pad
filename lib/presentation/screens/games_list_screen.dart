import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:scoring_pad/managers/current_game_manager.dart';
import 'package:scoring_pad/models/game_catalog.dart';
import 'package:scoring_pad/models/player.dart';
import 'package:scoring_pad/presentation/graphic_tools.dart';
import 'package:talker/talker.dart';

import '../../managers/games_manager.dart';
import '../../models/game.dart';
import '../widgets/widget_tools.dart';
import '../widgets/default_dismissible.dart';

final talker = Talker();

class GamesListScreen extends ConsumerWidget {
  static const String path = 'games-list';

  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final games = ref.watch(gamesManager);
    return ContextualScaffold<Game>(
      contextualAppBar: ContextualAppBar(
        counterBuilder: (int itemsCount) {
          return Text(tr.selectedGames(itemsCount));
        },
        contextualActions: [
          ContextualAction(
            itemsHandler: (List<Game> items) {
              _onDeleteGames(context, ref, tr, items);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(tr.gamesList),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView.separated(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return DefaultDismissible(
            key: Key(game.getKey()),
            icon: Icons.delete,
            onDismissed: () {
              _onDeleteGames(context, ref, tr, [game]);
            },
            confirmDismiss: (direction) async => await WidgetTools.checkInProgress(context, ref, [game]),
            child: ContextualActionWidget<Game>(
              data: game,
              child: _getContent(context, ref, tr, game),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  String _getStringFromPlayers(List<Player> players) {
    return players.map((e) => e.name).join(", ");
  }

  Widget _getContent(BuildContext context, WidgetRef ref, AppLocalizations tr, Game game) {
    return GestureDetector(
      onTap: () async {
        if (game.isFinished()) {
          final currentGame = ref.read(currentGameManager);
          if (currentGame.isInProgress()) {
            ref.read(gamesManager.notifier).saveGame(currentGame.game!);
          }
          ref.read(currentGameManager.notifier).continueGame(game);
          GameCatalog().getGameEngine(game.getGameType())?.endGame(context);
        } else {
          bool create = await WidgetTools.checkGameInProgress(context, ref);
          if (create) {
            if (!context.mounted) {
              talker.warning("Context not mounted");
              return;
            }
            ref.read(currentGameManager.notifier).continueGame(game);
            GameCatalog().getGameEngine(game.getGameType())?.continueGame(context, ref);
          }
        }
      },
      child: ListTile(
        title: Row(
          children: [
            Text(DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(game.getStartTime())),
            const SizedBox(width: 8),
            Text(DateFormat.Hms().format(game.getStartTime())),
          ],
        ),
        leading: game.getGameType().getIcon(),
        subtitle: Text(_getStringFromPlayers(game.getPlayers())),
        trailing: game.isFinished() ? const Icon(Icons.done) : null,
      ),
    );
  }

  void _onDeleteGames(BuildContext context, WidgetRef ref, AppLocalizations tr, List<Game> games) async {
    bool delete = await WidgetTools.checkInProgress(context, ref, games);
    if (delete) {
      if (!context.mounted) {
        talker.warning("Context not mounted");
        return;
      }
      ref.read(gamesManager.notifier).removeGames(games);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr.gamesDeleted(games.length)),
          action: SnackBarAction(
            onPressed: () {
              ref.read(gamesManager.notifier).undoRemove();
            },
            label: tr.undo,
          ),
        ),
      );
    }
  }
}
