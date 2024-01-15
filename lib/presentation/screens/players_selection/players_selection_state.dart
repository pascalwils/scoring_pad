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

class PlayersSelectionState {
  final List<SelectedPlayer> selectedPlayers;
  final List<Player> availablePlayers;
  final List<int> availableColorIndices;

  PlayersSelectionState({required this.selectedPlayers, required this.availablePlayers, required this.availableColorIndices});

  PlayersSelectionState copyWith({
    List<SelectedPlayer>? selectedPlayers,
    List<Player>? availablePlayers,
    List<int>? availableColorIndices,
  }) {
    return PlayersSelectionState(
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      availablePlayers: availablePlayers ?? this.availablePlayers,
      availableColorIndices: availableColorIndices ?? this.availableColorIndices,
    );
  }

  factory PlayersSelectionState.initial(List<Player>? players) => PlayersSelectionState(
        selectedPlayers: List<SelectedPlayer>.empty(),
        availablePlayers: players ?? List<Player>.empty(),
        availableColorIndices: List<int>.generate(lightColors.length, (index) => index, growable: true),
      );

  // TODO extract this logic in notifier
  bool isValid({required int minPlayers, required int maxPlayers}) {
    return selectedPlayers.length >= minPlayers && selectedPlayers.length <= maxPlayers;
  }
}
