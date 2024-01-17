import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../domain/repositories/player_repository.dart';
import '../../domain/entities/player.dart';
import '../in_memory_player_repository.dart';
import 'players_state.dart';

final talker = Talker();

class PlayerNotifier extends StateNotifier<PlayersState> {
  final PlayerRepository _repository;

  PlayerNotifier(this._repository) : super(const PlayersState.initial()) {
    _updateState();
  }

  Future<void> addPlayer(Player player) async {
    try {
      await _repository.addPlayer(player);
      _updateState();
    } catch (e) {
      talker.debug("Unable to add player '${player.name}' in repository", e);
    }
  }

  Future<void> removePlayer(Player player) async {
    try {
      await _repository.removePlayer(player);
      _updateState();
    } catch (e) {
      talker.debug("Unable to remove player '${player.name}' in repository", e);
    }
  }

  void _updateState() async {
    try {
      final players = await _repository.getAllPlayers();
      state = state.copyWith(players: players);
    } catch (e) {
      talker.debug("Unable to get all players from repository", e);
    }
  }
}

final playersProvider = StateNotifierProvider<PlayerNotifier, PlayersState>(
  (ref) {
    final repository = ref.watch(playerRepositoryProvider);
    return PlayerNotifier(repository);
  },
);
