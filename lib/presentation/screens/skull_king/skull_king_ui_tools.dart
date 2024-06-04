import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoring_pad/models/skull_king/skull_king_game.dart';
import 'package:scoring_pad/presentation/screens/skull_king/skull_king_round_screen_state.dart';

import '../../../models/skull_king/skull_king_player_game.dart';
import '../../../models/skull_king/skull_king_player_round.dart';
import 'skull_king_round_edit_screen.dart';
import 'skull_king_round_screen.dart';

class SkullKingUiTools {
  // Prevent construction of this utility class
  SkullKingUiTools._();

  static Widget buildUndoActionButton(
    BuildContext context,
    int currentRound,
    AppLocalizations tr,
    Function(SkullKingGame) callback,
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
                  await context.push<SkullKingGame>('${SkullKingRoundScreen.path}/${SkullKingRoundEditScreen.path}/$value');
              callback(result!);
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

  static SkullKingGame updateGameFromState(SkullKingGame game, SkullKingRoundScreenState state, int roundIndex) {
    var copyPlayerGames = List<SkullKingPlayerGame>.from(game.playerGames);
    for (int i = 0; i < game.playerGames.length; i++) {
      var playerGame = game.playerGames[i];
      var copyRounds = List<SkullKingPlayerRound>.from(playerGame.rounds);
      copyRounds[roundIndex] = state.rounds[i];
      copyPlayerGames[i] = playerGame.copyWith(rounds: copyRounds);
    }
    return game.copyWith(currentRound: roundIndex + 1, playerGames: copyPlayerGames);
  }
}
