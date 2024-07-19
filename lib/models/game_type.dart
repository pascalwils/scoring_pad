import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';

part 'game_type.g.dart';

@HiveType(typeId: gameTypeTypeId)
enum GameType {
  @HiveField(0)
  papayoo(73365),
  @HiveField(1)
  prophecy(373435),
  @HiveField(2)
  take5(432),
  @HiveField(3)
  skullking(150145),
  @HiveField(4)
  free(-1);

  const GameType(this.id);

  final num id;

  static GameType fromId(int id) {
      return GameType.values.firstWhere((e) => e.id == id);
  }
}
