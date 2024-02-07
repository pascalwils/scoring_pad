import 'package:hive/hive.dart';
import 'package:scoring_pad/data/adapters/adapter_type_ids.dart';

import '../../domain/entities/game_player.dart';

class GamePlayerAdapter extends TypeAdapter<GamePlayer> {
  @override
  int get typeId => gamePlayerTypeId;

  @override
  GamePlayer read(BinaryReader reader) {
    final String name = reader.readString();
    final int colorIndex = reader.readInt();
    return GamePlayer(name: name, colorIndex: colorIndex);
  }

  @override
  void write(BinaryWriter writer, GamePlayer obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.colorIndex);
  }
}
