import '../../domain/entities/game.dart';
import '../../domain/entities/game_player.dart';
import '../../domain/entities/game_type.dart';

class GameState {
  static const String gameTypeKey = "gameType";
  static const String playersKey = "players";
  static const String gameKey = "game";

  final GameType? gameType;
  final List<GamePlayer> players;
  final Game? game;

  const GameState({
    this.gameType,
    required this.players,
    this.game,
  });

  factory GameState.initial() => const GameState(players: []);

  GameState copyWith({GameType? gameType, List<GamePlayer>? players, Game? game}) {
    return GameState(
      gameType: gameType ?? this.gameType,
      players: players ?? this.players,
      game: game ?? this.game,
    );
  }
}
