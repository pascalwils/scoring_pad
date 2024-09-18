import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';

import '../../../managers/current_game_manager.dart';
import '../../../managers/games_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import 'skull_king_score_screen_state_provider.dart';
import '../../widgets/score_widget.dart';
import 'skull_king_ui_tools.dart';

class SkullKingEndScreen extends ConsumerWidget {
  static const String path = "/skull-king-end";

  final _globalKey = GlobalKey();

  SkullKingEndScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations tr = AppLocalizations.of(context);
    final game = ref.read(currentGameManager).game as SkullKingGame;
    final state = ref.watch(skullKingScoreScreenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.scoreboard),
        leading: SkullKingUiTools.buildUndoActionButton(
          context,
          game.nbRounds(),
          tr,
          (SkullKingGame? updatedGame) {
            if (updatedGame != null) {
              ref.read(skullKingScoreScreenProvider.notifier).update(updatedGame);
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
              final game = ref.read(currentGameManager).game as SkullKingGame;
              ref.read(gamesManager.notifier).saveGame(game.copyWith(finished: true));
              ref.read(currentGameManager.notifier).clear();
              context.go("/");
            },
            child: Icon(
              Icons.close,
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
                  tr.skEndMessage(state.scores[0].player.name),
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
