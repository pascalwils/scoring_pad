import 'player.dart';

class GamePlayer {
  final String name;
  final int colorIndex;

  GamePlayer({required this.name, required this.colorIndex});

  factory GamePlayer.fromPlayer(Player player, int colorIndex) {
    return GamePlayer(name: player.name, colorIndex: colorIndex);
  }
}
