import 'package:hive/hive.dart';

import '../../../domain/entities/skullking/skullking_player_round.dart';
import '../adapter_type_ids.dart';

class SkullkingPlayerGameAdapter extends TypeAdapter<SkullkingPlayerGame> {
  @override
  int get typeId => skullkingPlayerGameTypeId;

  @override
  SkullkingPlayerGame read(BinaryReader reader) {
    final rounds = List<SkullkingPlayerRound>.from(reader.readList());
    return SkullkingPlayerGame.fromDatasource(rounds: rounds);
  }

  @override
  void write(BinaryWriter writer, SkullkingPlayerGame obj) {
    writer.writeList(obj.rounds);
  }
}
