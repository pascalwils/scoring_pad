
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/managers/current_game_manager.dart';
import 'package:scoring_pad/managers/games_manager.dart';
import 'package:scoring_pad/models/game.dart';
import 'package:scoring_pad/models/game_type.dart';
import 'package:scoring_pad/presentation/graphic_tools.dart';
import 'package:scoring_pad/presentation/widgets/widget_tools.dart';
import 'package:scoring_pad/translation_support.dart';
import 'package:talker/talker.dart';

import '../../managers/players_manager.dart';
import '../../models/player.dart';
import '../widgets/player_edition/player_edition_dialog.dart';

final talker = Talker();

class PlayerDetailsScreen extends ConsumerWidget {
  static const String path = 'player-details';

  const PlayerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final currentPlayer = ref.watch(currentPlayerProvider);
    final games = ref.watch(gamesManager);
    final List<GameStatistics> statistics = _computeStatistics(currentPlayer, games);
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
              if (_isPlayerEditable(ref, currentPlayer.name)) {
                var player = await _displayTextInputDialog(context, currentPlayer);
                if (player != null) {
                  ref.read(playersManager.notifier).removePlayer(currentPlayer);
                  ref.read(playersManager.notifier).addPlayer(player);
                  ref.read(gamesManager.notifier).renamePlayer(currentPlayer, player);
                  ref.read(currentPlayerProvider.notifier).setPlayer(player);
                }
              } else {
                WidgetTools.showAlertDialog(
                  context: context,
                  title: tr.playerRenameDialogTitle,
                  content: [Text(tr.playerRenameContent)],
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (_isPlayerEditable(ref, currentPlayer.name)) {
                bool? confirm = await _showDeleteConfirmDialog(context, currentPlayer.name);
                if (confirm != null && confirm) {
                  ref.read(playersManager.notifier).removePlayer(currentPlayer);
                  if (!context.mounted) {
                    talker.warning("Context not mounted");
                    return;
                  }
                  context.pop();
                }
              } else {
                WidgetTools.showAlertDialog(
                  context: context,
                  title: tr.playerDeleteDialogTitle,
                  content: [Text(tr.playerDeleteContent)],
                );
              }
            },
          ),
        ],
      ),
      body: statistics.isEmpty
          ? Center(child: Text(tr.noGamePlayed))
          : ListView.separated(
              itemCount: statistics.length,
              itemBuilder: (context, index) {
                final stat = statistics[index];
                return ListTile(
                  leading: stat.type.getIcon(),
                  title: Text(stat.type.getName(tr)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr.playerStatWonGames(stat.nbWon, stat.nbPlayed)),
                      Text(tr.playerStatScores(stat.scoreMax ?? 0, stat.scoreMin ?? 0))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
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

  bool _isPlayerEditable(WidgetRef ref, String playerName) {
    return ref.read(currentGameManager).players.indexWhere((it) => it.name == playerName) < 0;
  }

  List<GameStatistics> _computeStatistics(Player player, List<Game> games) {
    List<GameStatistics> result = [];
    for (Game game in games) {
      if (game.isFinished() && game.getPlayers().contains(player)) {
        final type = game.getGameType();
        final statIndex = result.indexWhere((it) => it.type == type);
        final stat = statIndex >= 0 ? result[statIndex] : GameStatistics(type);
        if (statIndex == -1) {
          result.add(stat);
        }

        stat.nbPlayed++;

        final scores = game.getScores();
        final playerIndex = game.getPlayers().indexWhere((it) => it.name == player.name);
        final playerScore = playerIndex < scores.length ? scores[playerIndex] : 0;
        if (game.isWinner(player)) {
          stat.nbWon++;
        }
        if (stat.scoreMax == null || stat.scoreMax! < playerScore) {
          stat.scoreMax = playerScore;
        }
        if (stat.scoreMin == null || stat.scoreMin! > playerScore) {
          stat.scoreMin = playerScore;
        }
      }
    }
    return result;
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
    return CurrentPlayerNotifier(const Player(name: ""));
  },
);

class GameStatistics {
  final GameType type;
  int nbPlayed = 0;
  int nbWon = 0;
  int? scoreMax;
  int? scoreMin;

  GameStatistics(this.type);
}
