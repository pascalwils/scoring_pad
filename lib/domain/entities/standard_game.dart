import 'game.dart';
import 'player.dart';
import 'game_type.dart';

sealed class StandardGame implements Game {
  final List<Player> _players;
  final GameType _type;
  int _currentRound = 0;
  bool _finished = false;
  late final List<List<int>> _rounds;
  late final DateTime _startTime;

  StandardGame({
    required List<Player> players,
    required GameType type,
    required int nbMinPlayers,
    required int nbMaxPlayers,
  }) : _type = type, _players = players {
    assert(_players.length >= nbMinPlayers);
    assert(_players.length <= nbMaxPlayers);

    _startTime = DateTime.now();
    _rounds = List.filled(_players.length, List.empty(growable: true));
  }

  @override
  List<Player> getPlayers() => _players;

  @override
  List<List<int>> getRounds() => _rounds;

  @override
  DateTime getStartTime() => _startTime;
  @override
  bool isFinished() => _finished;

  @override
  GameType getGameType() => _type;
}

class PapayooGame extends StandardGame {
  static const int nbMinPlayers = 3;
  static const int nbMaxPlayers = 8;

  PapayooGame({required super.players})
      : super(
          type: GameType.papayoo,
          nbMinPlayers: nbMinPlayers,
          nbMaxPlayers: nbMaxPlayers,
        );
}

class ProphecyGame extends StandardGame {
  static const int nbMinPlayers = 2;
  static const int nbMaxPlayers = 6;

  ProphecyGame({required super.players})
      : super(
          type: GameType.prophecy,
          nbMinPlayers: nbMinPlayers,
          nbMaxPlayers: nbMaxPlayers,
        );
}

class Take5Game extends StandardGame {
  static const int nbMinPlayers = 2;
  static const int nbMaxPlayers = 10;

  Take5Game({required super.players})
      : super(
          type: GameType.take5,
          nbMinPlayers: nbMinPlayers,
          nbMaxPlayers: nbMaxPlayers,
        );
}
