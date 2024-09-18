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

  bool isWinner(Player player);

  String getKey() {
    return getStartTime().millisecondsSinceEpoch.toString();
  }

  int compareTo(Game other) => getStartTime().millisecondsSinceEpoch.compareTo(other.getStartTime().millisecondsSinceEpoch);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Game && runtimeType == other.runtimeType && compareTo(other) == 0;

  @override
  int get hashCode => getStartTime().millisecondsSinceEpoch.hashCode;


}
