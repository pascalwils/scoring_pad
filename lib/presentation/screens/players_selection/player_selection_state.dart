import '../../../domain/entities/player.dart';
import '../../palettes.dart';

class SelectedPlayer {
  final String name;
  final int colorIndex;

  SelectedPlayer({required this.name, required this.colorIndex});

  factory SelectedPlayer.fromPlayer(Player player, int colorIndex) {
    return SelectedPlayer(name: player.name, colorIndex: colorIndex);
  }
}

class PlayerSelectionState {
  final List<SelectedPlayer> selectedPlayers;
  final List<int> availableColorIndices;

  PlayerSelectionState({required this.selectedPlayers, required this.availableColorIndices});

  PlayerSelectionState copyWith({
    List<SelectedPlayer>? selectedPlayers,
    List<Player>? availablePlayers,
    List<int>? availableColorIndices,
  }) {
    return PlayerSelectionState(
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      availableColorIndices: availableColorIndices ?? this.availableColorIndices,
    );
  }

  factory PlayerSelectionState.initial() => PlayerSelectionState(
        selectedPlayers: List<SelectedPlayer>.empty(),
        availableColorIndices: List<int>.generate(lightColors.length, (index) => index, growable: true),
      );

  bool isValid({required int minPlayers, required int maxPlayers}) {
    return selectedPlayers.length >= minPlayers && selectedPlayers.length <= maxPlayers;
  }

  bool contains(Player player) {
    return selectedPlayers.any((e) => e.name == player.name);
  }
}
