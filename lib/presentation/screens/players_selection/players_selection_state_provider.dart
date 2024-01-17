import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../data/players/players_notifier.dart';
import '../../../domain/entities/player.dart';
import 'players_selection_state.dart';

final talker = Talker();

class PlayersSelectionScreenNotifier extends AutoDisposeNotifier<PlayersSelectionState> {
  @override
  PlayersSelectionState build() {
    talker.debug("Build players selection state");
    return PlayersSelectionState.initial(ref.read(playersProvider).players);
  }

  void addNewPlayer(Player player) {
    final currentlyAvailableColorIndices = List<int>.from(state.availableColorIndices);
    final newPlayer = SelectedPlayer.fromPlayer(player, currentlyAvailableColorIndices.removeAt(0));
    state = state.copyWith(
      selectedPlayers: [...state.selectedPlayers, newPlayer],
      availableColorIndices: currentlyAvailableColorIndices,
    );
  }

  void addPlayer(String name) {
    int index = state.availablePlayers.indexWhere((e) => e.name == name);
    final currentlyAvailablePlayers = List<Player>.from(state.availablePlayers);
    final Player player = currentlyAvailablePlayers.removeAt(index);
    final currentlyAvailableColorIndices = List<int>.from(state.availableColorIndices);
    final newPlayer = SelectedPlayer.fromPlayer(player, currentlyAvailableColorIndices.removeAt(0));
    state = state.copyWith(
      selectedPlayers: [...state.selectedPlayers, newPlayer],
      availablePlayers: currentlyAvailablePlayers,
      availableColorIndices: currentlyAvailableColorIndices,
    );
  }

  void deletePlayer(int index) {
    final currentlySelectedPlayers = state.selectedPlayers;
    final SelectedPlayer player = currentlySelectedPlayers.removeAt(index);
    state = state.copyWith(
      selectedPlayers: currentlySelectedPlayers,
      availablePlayers: [...state.availablePlayers, Player(name: player.name)],
      availableColorIndices: [...state.availableColorIndices, player.colorIndex],
    );
  }

  void reorderPlayers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final currentlySelectedPlayers = state.selectedPlayers;
    final SelectedPlayer item = currentlySelectedPlayers.removeAt(oldIndex);
    currentlySelectedPlayers.insert(newIndex, item);
    state = state.copyWith(selectedPlayers: currentlySelectedPlayers);
  }
}

final playersSelectionScreenNotifierProvider =
    NotifierProvider.autoDispose<PlayersSelectionScreenNotifier, PlayersSelectionState>(PlayersSelectionScreenNotifier.new);
