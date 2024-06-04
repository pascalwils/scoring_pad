import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';

import 'skull_king_game_mode.dart';
import 'skull_king_rules.dart';

part 'skull_king_game_parameters.freezed.dart';

part 'skull_king_game_parameters.g.dart';

@freezed
class SkullKingGameParameters with _$SkullKingGameParameters {
  @HiveType(typeId: skullKingParametersTypeId, adapterName: "SkullKingParametersAdapter")
  const factory SkullKingGameParameters({
    @HiveField(0) @Default(SkullKingGameMode.regular) SkullKingGameMode mode,
    @HiveField(1) @Default(SkullKingRules.initial) SkullKingRules rules,
    @HiveField(2) @Default(false) bool lootCardsPresent,
    @HiveField(3) @Default(false) bool advancedPirateAbilitiesEnabled,
    @HiveField(4) @Default(false) bool additionalBonusesEnabled,
  }) = _SkullKingGameParameters;
}
