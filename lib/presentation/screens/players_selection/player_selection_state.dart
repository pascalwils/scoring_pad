import '../../../domain/entities/game_player.dart';
import '../../../domain/entities/player.dart';
import '../../palettes.dart';

class PlayerSelectionState {
  final List<GamePlayer> selectedPlayers;
  final List<int> availableColorIndices;

  PlayerSelectionState({required this.selectedPlayers, required this.availableColorIndices});

  PlayerSelectionState copyWith({
    List<GamePlayer>? selectedPlayers,
    List<Player>? availablePlayers,
    List<int>? availableColorIndices,
  }) {
    return PlayerSelectionState(
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      availableColorIndices: availableColorIndices ?? this.availableColorIndices,
    );
  }

  factory PlayerSelectionState.initial() => PlayerSelectionState(
        selectedPlayers: List<GamePlayer>.empty(),
        availableColorIndices: List<int>.generate(lightColors.length, (index) => index, growable: true),
      );

  bool isValid({required int minPlayers, required int maxPlayers}) {
    return selectedPlayers.length >= minPlayers && selectedPlayers.length <= maxPlayers;
  }

  bool contains(Player player) {
    return selectedPlayers.any((e) => e.name == player.name);
  }
}
