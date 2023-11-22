import 'package:scoring_pad/domain/entities/player.dart';

class Game {
  final List<Player> players;
  late final List<int> scores;
  int currentRound = 0;

  Game({required this.players}) {
    scores = List.filled(players.length, 0);
  }
}
