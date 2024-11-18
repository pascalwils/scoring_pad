import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:scoring_pad/models/standard_game_parameters.dart';
import 'package:scoring_pad/presentation/screens/standard_game/standard_game_round_screen_state.dart';

import '../../../models/standard_game.dart';
import '../../widgets/score_widget_state.dart';
import 'standard_game_player_round_state.dart';
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
    bool endGame = false,
  }) {
    bool updateRound = true;
    if (endGame) {
      updateRound = !state.isEmpty();
    }
    if (updateRound) {
      var copyRounds = List<List<int>>.empty(growable: true);
      for (int i = 0; i < game.players.length; i++) {
        var playerRounds = List<int>.from(game.rounds[i], growable: true);
        playerRounds[roundIndex ?? game.currentRound] = state.players[i].roundScore;
        if (roundIndex == null && !endGame) {
          playerRounds.add(0);
        }
        copyRounds.add(playerRounds);
      }
      if ((roundIndex == null && !endGame) || endGame) {
        return game.copyWith(currentRound: game.currentRound + 1, rounds: copyRounds);
      }
      return game.copyWith(rounds: copyRounds);
    } else {
      // clean last round if empty
      if (game.rounds.every((it) => it.last == 0)) {
        final newRounds = game.rounds.map((it) => it.take(it.length - 1).toList(growable: false)).toList(growable: false);
        return game.copyWith(rounds: newRounds);
      }
    }
    return game.copyWith();
  }

  static StandardGameRoundScreenState getStateFromGame(StandardGame game, int currentRound) {
    List<StandardGamePlayerRoundState> players = List.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      final rounds = game.rounds[i];
      players.add(
        StandardGamePlayerRoundState(
          name: game.players[i].name,
          colorIndex: game.players[i].colorIndex,
          totalScore: rounds.take(currentRound).fold(0, (a, b) => a + b),
          roundScore: rounds[currentRound],
        ),
      );
    }
    int totalRoundScore = game.rounds.map((it) => it[currentRound]).fold(0, (a, b) => a + b);
    return StandardGameRoundScreenState(
      currentPageIndex: 0,
      currentRound: currentRound,
      parameters: game.parameters,
      players: players,
      roundTotal: totalRoundScore,
      isGameEnd: _checkGameEnd(game.parameters, game),
      remainder: game.parameters.roundScoreDefined ? game.parameters.roundScore - totalRoundScore : null,
      scoreState: getScoreStateFromGame(game),
    );
  }

  static bool _checkGameEnd(StandardGameParameters parameters, StandardGame game) {
    if (parameters.endScoreDefined) {
      final currentRound = game.currentRound;
      int maxScore = 0;
      for (int i = 0; i < game.players.length; i++) {
        final playerRounds = game.rounds[i];
        int total = playerRounds.sublist(0, currentRound + 1).reduce((a, b) => a + b);
        maxScore = max(maxScore, total);
      }
      return maxScore >= parameters.endScore;
    }
    return false;
  }

  static ScoreWidgetState getScoreStateFromGame(StandardGame game) {
    final currentRound = game.currentRound;
    final playerScores = List<PlayerScore>.empty(growable: true);
    for (int i = 0; i < game.players.length; i++) {
      final scores = List<int>.empty(growable: true);
      final playerRounds = game.rounds[i];
      int total = 0;
      scores.add(0);
      for (int j = 0; j < currentRound; j++) {
        total += playerRounds[j];
        scores.add(total);
      }
      playerScores.add(PlayerScore(player: game.players[i], scores: scores));
    }
    if (game.parameters.highScoreWins) {
      playerScores.sort((s1, s2) => s2.scores.last.compareTo(s1.scores.last));
    } else {
      playerScores.sort((s1, s2) => s1.scores.last.compareTo(s2.scores.last));
    }
    return ScoreWidgetState(scores: playerScores);
  }
}
