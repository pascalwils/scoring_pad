import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/models/standard_game.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';

import '../../../managers/current_game_manager.dart';
import '../../../managers/games_manager.dart';
import '../../widgets/score_widget.dart';
import 'standard_game_end_screen_provider.dart';
import 'standard_game_ui_tools.dart';

class StandardGameEndScreen extends ConsumerWidget {
  static const String path = "/standard-game-end";

  final _globalKey = GlobalKey();

  StandardGameEndScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final game = ref.read(currentGameManager).game as StandardGame;
    final state = ref.watch(standardGameEndScreenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.scoreboard),
        leading: StandardGameUiTools.buildUndoActionButton(
          context,
          game.rounds.length,
          tr,
          (StandardGame? updatedGame) {
            if (updatedGame != null) {
              ref.read(standardGameEndScreenProvider.notifier).update(updatedGame);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              shareWidgets(globalKey: _globalKey);
            },
            child: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          TextButton(
            onPressed: () {
              final game = ref.read(currentGameManager).game as StandardGame;
              ref.read(gamesManager.notifier).saveGame(game.copyWith(finished: true));
              ref.read(currentGameManager.notifier).clear();
              context.go("/");
            },
            child: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
      body: ShareScreenshotAsImage(
        globalKey: _globalKey,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  tr.winnerMessage(state.scores[0].player.name),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ScoreWidget(state: state),
            ),
          ],
        ),
      ),
    );
  }
}
