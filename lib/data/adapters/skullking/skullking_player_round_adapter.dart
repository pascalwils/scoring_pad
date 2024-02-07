import 'package:hive/hive.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_player_round.dart';

import '../adapter_type_ids.dart';

class SkullkingPlayerRoundAdapter extends TypeAdapter<SkullkingPlayerRound> {
  @override
  int get typeId => skullkingPlayerRoundTypeId;

  @override
  SkullkingPlayerRound read(BinaryReader reader) {
    final int bids = reader.readInt();
    final int won = reader.readInt();
    final int standard14 = reader.readInt();
    final int black14 = reader.readInt();
    final int mermaids = reader.readInt();
    final int pirates = reader.readInt();
    final int skullking = reader.readInt();
    final int loots = reader.readInt();
    final int rascalBid = reader.readInt();
    return SkullkingPlayerRound(
      bids: bids,
      won: won,
      standard14: standard14,
      black14: black14,
      mermaids: mermaids,
      pirates: pirates,
      skullking: skullking,
      loots: loots,
      rascalBid: rascalBid,
    );
  }

  @override
  void write(BinaryWriter writer, SkullkingPlayerRound obj) {
    writer.writeInt(obj.bids);
    writer.writeInt(obj.won);
    writer.writeInt(obj.standard14);
    writer.writeInt(obj.black14);
    writer.writeInt(obj.mermaids);
    writer.writeInt(obj.pirates);
    writer.writeInt(obj.skullking);
    writer.writeInt(obj.loots);
    writer.writeInt(obj.rascalBid);
  }
}
