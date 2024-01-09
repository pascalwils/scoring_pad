import 'game_type.dart';
import 'player.dart';

abstract class Game {
  List<Player> getPlayers();
  List<List<int>> getRounds();
  DateTime getStartTime();
  bool isFinished();
  GameType getGameType();
}
