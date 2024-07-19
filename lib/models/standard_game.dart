import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:scoring_pad/models/standard_game_parameters.dart';

import '../data/adapter_type_ids.dart';
import 'game.dart';
import 'game_player.dart';
import 'player.dart';
import 'game_type.dart';

part 'standard_game.freezed.dart';
part 'standard_game.g.dart';

@freezed
sealed class StandardGame extends Game with _$StandardGame {
  const StandardGame._();

  @HiveType(typeId: standardGameTypeId, adapterName: "StandardGameAdapter")
  const factory StandardGame({
    @HiveField(0) required GameType type,
    @HiveField(1) required List<GamePlayer> players,
    @HiveField(2) required int currentRound,
    @HiveField(3) required bool finished,
    @HiveField(4) required DateTime startTime,
    @HiveField(5) required StandardGameParameters parameters,
    @HiveField(6) required List<List<int>> rounds,
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
