import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../models/game_player.dart';
import 'player_selection_state.dart';

final talker = Talker();

class PlayerSelectionNotifier extends StateNotifier<PlayerSelectionState> {
  PlayerSelectionNotifier() : super(PlayerSelectionState.initial());

  void addPlayer(String player) {
    final currentlyAvailableColorIndices = List<int>.from(state.availableColorIndices);
    final newPlayer = GamePlayer(name: player, colorIndex: currentlyAvailableColorIndices.removeAt(0));
    state = state.copyWith(
      selectedPlayers: [...state.selectedPlayers, newPlayer],
      availableColorIndices: currentlyAvailableColorIndices,
    );
  }

  void deletePlayer(int index) {
    final currentlySelectedPlayers = state.selectedPlayers;
    final GamePlayer player = currentlySelectedPlayers.removeAt(index);
    state = state.copyWith(
      selectedPlayers: currentlySelectedPlayers,
      availableColorIndices: [...state.availableColorIndices, player.colorIndex],
    );
  }

  void reorderPlayers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final currentlySelectedPlayers = state.selectedPlayers;
    final GamePlayer item = currentlySelectedPlayers.removeAt(oldIndex);
    currentlySelectedPlayers.insert(newIndex, item);
    state = state.copyWith(selectedPlayers: currentlySelectedPlayers);
  }
}

final playerSelectionProvider = StateNotifierProvider.autoDispose<PlayerSelectionNotifier, PlayerSelectionState>(
  (ref) {
    return PlayerSelectionNotifier();
  },
);
