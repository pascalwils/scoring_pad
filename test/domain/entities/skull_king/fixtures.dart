import 'package:scoring_pad/models/game_player.dart';
import 'package:scoring_pad/models/skull_king/skull_king_game.dart';
import 'package:scoring_pad/models/skull_king/skull_king_game_mode.dart';
import 'package:scoring_pad/models/skull_king/skull_king_game_parameters.dart';
import 'package:scoring_pad/models/skull_king/skull_king_player_game.dart';
import 'package:scoring_pad/models/skull_king/skull_king_player_round.dart';

SkullKingGame skullkingSimpleGameFixture() {
  int nbRounds = SkullKingGameMode.regular.nbCards.length;
  final rounds = List<SkullKingPlayerGame>.generate(
    2,
    (_) => SkullKingPlayerGame(rounds: List.filled(nbRounds, const SkullKingPlayerRound())),
  );
  return SkullKingGame(
    players: [const GamePlayer(name: "A", colorIndex: 0), const GamePlayer(name: "B", colorIndex: 1)],
    parameters: const SkullKingGameParameters(),
    currentRound: 1,
    startTime: DateTime.now(),
    playerGames: rounds,
    finished: false,
  );
}
