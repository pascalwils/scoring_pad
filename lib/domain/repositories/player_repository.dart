import 'package:scoring_pad/domain/entities/player.dart';

abstract class PlayerRepository {
  Future<bool> addPlayer(Player player);
  Future<bool> removePlayer(Player player);
  Future<List<Player>> getAllPlayers();
}
