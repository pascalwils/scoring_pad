import '../../domain/entities/game_type.dart';
import '../../presentation/screens/players_selection/player_selection_state.dart';

enum GameStatus {
  notStarted,
  selectingPlayers,
  started;

  static GameStatus fromString(String name) => GameStatus.values.firstWhere(
        (e) => e.name == name,
        orElse: () => GameStatus.notStarted,
      );
}

class GameState {
  static const String gameTypeKey = "gameType";
  static const String playersKey = "players";
  static const String statusKey = "status";

  final GameType? gameType;
  final List<SelectedPlayer>? players;
  final GameStatus status;

  const GameState({
    this.gameType,
    this.players,
    this.status = GameStatus.notStarted,
  });

  GameState copyWith({GameType? gameType, GameStatus? status, List<SelectedPlayer>? players}) {
    return GameState(
      gameType: gameType ?? this.gameType,
      players: players ?? this.players,
      status: status ?? this.status,
    );
  }
}
