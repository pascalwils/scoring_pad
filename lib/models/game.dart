import 'game_type.dart';
import 'player.dart';

abstract class Game {
  const Game();

  List<Player> getPlayers();

  List<int> getScores();

  Game setPlayers(List<Player> newPlayers);

  DateTime getStartTime();

  bool isFinished();

  GameType getGameType();

  int compareTo(Game other) => getStartTime().millisecondsSinceEpoch.compareTo(other.getStartTime().millisecondsSinceEpoch);

  String getKey() {
    return getStartTime().millisecondsSinceEpoch.toString();
  }
}
