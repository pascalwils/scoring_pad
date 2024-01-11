import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';

class InMemoryPlayerRepository implements PlayerRepository {
  final List<Player> _players = List<Player>.empty(growable: true);

  @override
  bool addPlayer(Player player) {
    if (!_players.contains(player)) {
      _players.add(player);
      return true;
    }
    return false;
  }

  @override
  bool removePlayer(Player player) {
    return _players.remove(player);
  }

  @override
  List<Player> getAllPlayers() => _players;

  @override
  bool containsPlayer(String name) {
    return _players.any((e) => e.name == name);
  }
}
