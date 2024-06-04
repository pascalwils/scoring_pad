import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../data/adapter_type_ids.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class Player with _$Player {
  @HiveType(typeId: playerTypeId, adapterName: 'PlayerAdapter')
  const factory Player({@HiveField(0) required String name}) = _Player;
}
