import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';
import 'skull_king_player_round.dart';

part 'skull_king_player_game.freezed.dart';
part 'skull_king_player_game.g.dart';

@freezed
class SkullKingPlayerGame with _$SkullKingPlayerGame {
  const SkullKingPlayerGame._();

  @HiveType(typeId: skullKingPlayerGameTypeId, adapterName: "SkullKingPlayerGameAdapter")
  const factory SkullKingPlayerGame({@HiveField(0) required List<SkullKingPlayerRound> rounds}) = _SkullKingPlayerGame;

  SkullKingPlayerRound getRound(int index) => rounds[index];
}
