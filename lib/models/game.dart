import 'game_type.dart';
import 'player.dart';

abstract class Game {
  List<Player> getPlayers();
  DateTime getStartTime();
  bool isFinished();
  GameType getGameType();
}
