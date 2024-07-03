import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';
import 'skull_king_round_field.dart';

part 'skull_king_player_round.freezed.dart';
part 'skull_king_player_round.g.dart';

@freezed
class SkullKingPlayerRound with _$SkullKingPlayerRound {
  const SkullKingPlayerRound._();

  @HiveType(typeId: skullKingPlayerRoundTypeId, adapterName: "SkullKingPlayerRoundAdapter")
  const factory SkullKingPlayerRound({
    @HiveField(0) @Default({}) Map<SkullKingRoundField, int> fields,
    @HiveField(1, defaultValue: null) @Default(null) bool? cannonball,
  }) = _SkullKingPlayerRound;

  int getValue(SkullKingRoundField field) => fields[field] ?? 0;
}
