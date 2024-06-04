import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../managers/current_game_manager.dart';
import '../../../models/skull_king/skull_king_game.dart';
import 'skull_king_score_screen_state_provider.dart';
import 'skull_king_score_widget.dart';
import 'skull_king_ui_tools.dart';

class SkullKingEndScreen extends ConsumerWidget {
  static const String path = "/skull-king-end";

  const SkullKingEndScreen({super.key});

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
          (SkullKingGame updatedGame) => ref.read(skullKingScoreScreenProvider.notifier).update(updatedGame),
        ),
        actions: [
          TextButton(
            onPressed: () {
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
      body: SkullKingScoreWidget(state: state),
    );
  }
}
