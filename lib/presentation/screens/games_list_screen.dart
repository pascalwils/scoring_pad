import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:scoring_pad/managers/current_game_manager.dart';
import 'package:scoring_pad/models/game_catalog.dart';
import 'package:scoring_pad/models/player.dart';
import 'package:scoring_pad/translation_support.dart';
import 'package:talker/talker.dart';

import '../../managers/games_manager.dart';
import '../../models/game.dart';
import '../widgets/widget_tools.dart';

final talker = Talker();

class GamesListScreen extends ConsumerWidget {
  static const String path = 'games-list';

  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final games = ref.watch(gamesManager);
    final background = ref.watch(dismissibleBackgroundProvider);
    return Scaffold(
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
          return Dismissible(
            key: Key(game.getKey()),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: background,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onUpdate: (details) {
              if (details.reached && !details.previousReached) {
                ref.read(dismissibleBackgroundProvider.notifier).enable();
              } else if (!details.reached && details.previousReached) {
                ref.read(dismissibleBackgroundProvider.notifier).disable();
              }
            },
            onDismissed: (direction) {
              _onDelete(context, ref, tr, game);
            },
            child: _getContent(context, ref, tr, game),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  String _getStringFromPlayers(List<Player> players) {
    return players.map((e) => e.name).join(",");
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
            Text(game.getGameType().getName(tr)),
            const SizedBox(width: 8),
            Text(DateFormat.yMMMd().format(game.getStartTime())),
            const SizedBox(width: 8),
            Text(DateFormat.Hms().format(game.getStartTime())),
          ],
        ),
        subtitle: Text(_getStringFromPlayers(game.getPlayers())),
        trailing: game.isFinished() ? const Icon(Icons.done) : null,
      ),
    );
  }

  void _onDelete(BuildContext context, WidgetRef ref, AppLocalizations tr, Game game) {
    ref.read(gamesManager.notifier).removeGame(game);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr.gameDeleted),
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

class DismissibleBackgroundNotifier extends Notifier<Color> {
  @override
  Color build() => Colors.white30;

  void enable() {
    state = const Color(0xFFFE4A49);
  }

  void disable() {
    state = Colors.white30;
  }
}

final dismissibleBackgroundProvider = NotifierProvider<DismissibleBackgroundNotifier, Color>(
  DismissibleBackgroundNotifier.new,
);
