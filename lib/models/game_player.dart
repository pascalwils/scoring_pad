import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';
import 'player.dart';

part 'game_player.freezed.dart';

part 'game_player.g.dart';

@freezed
class GamePlayer with _$GamePlayer {
  const GamePlayer._();

  @HiveType(typeId: gamePlayerTypeId, adapterName: "GamePlayerAdapter")
  const factory GamePlayer({
    @HiveField(0) required String name,
    @HiveField(1) required int colorIndex,
  }) = _GamePlayer;

  factory GamePlayer.fromPlayer(Player player, int colorIndex) {
    return GamePlayer(name: player.name, colorIndex: colorIndex);
  }
}
