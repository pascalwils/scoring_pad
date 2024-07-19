import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_round_screen_state.dart';

import '../../../models/standard_game.dart';
import '../../widgets/score_widget_state.dart';
import 'standard_game_round_edit_screen.dart';
import 'standard_game_round_screen.dart';

class StandardGameUiTools {
  // Prevent construction of this utility class
  StandardGameUiTools._();

  static Widget buildUndoActionButton(
    BuildContext context,
    int currentRound,
    AppLocalizations tr,
    Function(StandardGame?) callback,
  ) {
    if (currentRound > 0) {
      final items = List<int>.generate(currentRound, (index) => index);
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Icon(
            Icons.undo,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          items: [
            ...items.map(
              (e) => DropdownMenuItem<int>(
                value: e,
                child: Text(
                  tr.roundNumber(e + 1),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ),
          ],
          onChanged: (value) async {
            if (value != null) {
              final result =
                  await context.push<StandardGame>('${StandardGameRoundScreen.path}/${StandardGameRoundEditScreen.path}/$value');
              callback(result);
            }
          },
          dropdownStyleData: const DropdownStyleData(
            width: 100,
            padding: EdgeInsets.symmetric(vertical: 6),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 12,
      );
    }
  }

  static StandardGame updateGameFromState({
    required StandardGame game,
    required StandardGameRoundScreenState state,
    int? roundIndex,
  }) {
    return game.copyWith();
  }

  static ScoreWidgetState getScoreStateFromGame(StandardGame game) {
    final currentRound = game.currentRound;
    final playerScores = List<PlayerScore>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      final scores = List<int>.empty(growable: true);
      scores.add(0);
      for (int j = 0; j < currentRound; j++) {
        scores.add(game.rounds[i][j]);
      }
      playerScores.add(PlayerScore(player: game.players[i], scores: scores));
    }
    playerScores.sort((s1, s2) => s2.scores.last.compareTo(s1.scores.last));
    return ScoreWidgetState(scores: playerScores);
  }
}
