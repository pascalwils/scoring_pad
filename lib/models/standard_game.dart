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
  DateTime getStartTime() => startTime;

  @override
  bool isFinished() => finished;

  @override
  GameType getGameType() => type;
}
