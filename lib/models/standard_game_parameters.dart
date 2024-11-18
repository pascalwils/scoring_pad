import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';

part 'standard_game_parameters.freezed.dart';

part 'standard_game_parameters.g.dart';

@freezed
class StandardGameParameters with _$StandardGameParameters {
  @HiveType(typeId: standardGameParametersTypeId, adapterName: "StandardGameParametersAdapter")
  const factory StandardGameParameters({
    @HiveField(0) @Default(true) bool highScoreWins,
    @HiveField(1) @Default(false) bool roundScoreDefined,
    @HiveField(2) @Default(0) int roundScore,
    @HiveField(3, defaultValue: false) @Default(false) bool authorizedNegativeScore,
    @HiveField(4, defaultValue: false) @Default(false) bool endScoreDefined,
    @HiveField(5, defaultValue: 0) @Default(0) int endScore,
  }) = _StandardGameParameters;
}
