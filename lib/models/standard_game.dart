import 'package:freezed_annotation/freezed_annotation.dart';

import 'game.dart';
import 'game_player.dart';
import 'player.dart';
import 'game_type.dart';

part 'standard_game.freezed.dart';

@freezed
sealed class StandardGame extends Game with _$StandardGame {
  const StandardGame._();

  const factory StandardGame({
    required GameType type,
    required List<GamePlayer> players,
    required int currentRound,
    required bool finished,
    required DateTime startTime,
    required List<List<int>> rounds,
  }) = _StandardGame;

  @override
  List<Player> getPlayers() => players.map((e) => Player(name: e.name)).toList();

  @override
  List<int> getScores() {
    return rounds.last;
  }

  @override
  DateTime getStartTime() => startTime;

  @override
  bool isFinished() => finished;

  @override
  GameType getGameType() => type;

  @override
  Game setPlayers(List<Player> newPlayers) {
    assert(newPlayers.length == players.length);
    List<GamePlayer> newGamePlayers = List.empty(growable: true);
    for (int i = 0; i < newPlayers.length; i++) {
      newGamePlayers.add(GamePlayer(name: newPlayers[i].name, colorIndex: players[i].colorIndex));
    }
    return copyWith(players: newGamePlayers);
  }
}
