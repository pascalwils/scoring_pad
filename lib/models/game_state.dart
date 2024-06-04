import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';
import 'game.dart';
import 'game_player.dart';
import 'game_type.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
class GameState with _$GameState {
  @HiveType(typeId: gameStateTypeId, adapterName: 'GameStateAdapter')
  const factory GameState({
    @HiveField(0) GameType? gameType,
    @HiveField(1) required List<GamePlayer> players,
    @HiveField(2) Game? game,
  }) = _GameState;
}
