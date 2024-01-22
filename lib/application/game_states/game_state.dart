import '../../domain/entities/game_type.dart';
import '../../domain/entities/player.dart';

abstract class GameState {
  static const String gameTypeKey = "gameType";
  static const String playersKey = "players";

  GameType getGameType();

  List<Player> getPlayers();


}

class NoGameState implements GameState {
  @override
  GameType getGameType() {
    throw UnimplementedError();
  }

  @override
  List<Player> getPlayers() {
    throw UnimplementedError();
  }
}
