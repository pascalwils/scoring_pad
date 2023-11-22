import 'package:scoring_pad/domain/entities/player.dart';

abstract class PlayerRepository {
  bool addPlayer(Player player);
  bool removePlayer();
  List<Player> getAllPlayers();
}
