import 'package:hive/hive.dart';

import '../../data/adapter_type_ids.dart';

part 'skull_king_round_field.g.dart';

@HiveType(typeId: skullKingRoundFieldTypeId)
enum SkullKingRoundField {
  @HiveField(0)
  bids,
  @HiveField(1)
  won,
  @HiveField(2)
  standard14,
  @HiveField(3)
  black14,
  @HiveField(4)
  mermaids,
  @HiveField(5)
  pirates,
  @HiveField(6)
  skullKing,
  @HiveField(7)
  loots,
  @HiveField(8)
  rascalBid,
  @HiveField(9)
  bonuses,
}
