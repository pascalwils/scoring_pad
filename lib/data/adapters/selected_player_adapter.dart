import 'package:hive/hive.dart';
import 'package:scoring_pad/data/adapters/adapter_type_ids.dart';

import 'package:scoring_pad/presentation/screens/players_selection/player_selection_state.dart';

class SelectedPlayerAdapter extends TypeAdapter<SelectedPlayer> {
  @override
  int get typeId => selectedPlayerTypeId;

  @override
  SelectedPlayer read(BinaryReader reader) {
    final String name = reader.readString();
    final int colorIndex = reader.readInt();
    return SelectedPlayer(name: name, colorIndex: colorIndex);
  }

  @override
  void write(BinaryWriter writer, SelectedPlayer obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.colorIndex);
  }
}
