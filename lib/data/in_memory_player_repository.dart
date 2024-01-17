import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';

final talker = Talker();

class InMemoryPlayerRepository implements PlayerRepository {
  final List<Player> _players = List<Player>.empty(growable: true);

  @override
  Future<bool> addPlayer(Player player) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!_players.contains(player)) {
      _players.add(player);
      talker.debug("Add player ${player.name} to database.");
      return true;
    }
    return false;
  }

  @override
  Future<bool> removePlayer(Player player) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _players.remove(player);
  }

  @override
  Future<List<Player>> getAllPlayers() async {
    await Future.delayed(const Duration(milliseconds: 100));
    talker.debug("Get all players.");
    return _players;
  }
}

final playerRepositoryProvider = Provider<PlayerRepository>(
  (ref) {
    return InMemoryPlayerRepository();
  },
);
