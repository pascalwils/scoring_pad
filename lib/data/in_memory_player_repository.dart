import 'package:talker/talker.dart';
import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';

final talker = Talker();

class InMemoryPlayerRepository implements PlayerRepository {
  final List<Player> _players = List<Player>.empty(growable: true);

  @override
  bool addPlayer(Player player) {
    if (!_players.contains(player)) {
      _players.add(player);
      talker.debug("Add player ${player.name} to database.");
      return true;
    }
    return false;
  }

  @override
  bool removePlayer(Player player) {
    return _players.remove(player);
  }

  @override
  Future<List<Player>> getAllPlayers() async {
    talker.debug("Get all players.");
    return _players;
  }
}
