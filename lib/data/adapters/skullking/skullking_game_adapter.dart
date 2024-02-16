import 'package:hive/hive.dart';

import '../../../domain/entities/game_player.dart';
import '../../../domain/entities/skullking/skullking_game.dart';
import '../../../domain/entities/skullking/skullking_game_mode.dart';
import '../../../domain/entities/skullking/skullking_player_round.dart';
import '../adapter_type_ids.dart';

class SkullkingGameAdapter extends TypeAdapter<SkullkingGame> {
  @override
  int get typeId => skullkingGameTypeId;

  @override
  SkullkingGame read(BinaryReader reader) {
    final List<GamePlayer> players = List<GamePlayer>.from(reader.readList());
    final int currentRound = reader.readInt();
    final bool finished = reader.readBool();
    final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final SkullkingGameMode mode = SkullkingGameMode.fromString(reader.readString());
    final SkullkingRules rules = SkullkingRules.fromString(reader.readString());
    final bool lootCardsPresent = reader.readBool();
    final bool advancedPirateAbilitiesEnabled = reader.readBool();
    final bool additionalBonuses = reader.readBool();
    final rounds = reader.readList().map((e) => e as SkullkingPlayerGame).toList();
    return SkullkingGame.fromDatasource(
      players: players,
      currentRound: currentRound,
      finished: finished,
      startTime: startTime,
      mode: mode,
      rules: rules,
      lootCardsPresent: lootCardsPresent,
      advancedPirateAbilitiesEnabled: advancedPirateAbilitiesEnabled,
      additionalBonuses: additionalBonuses,
      rounds: rounds,
    );
  }

  @override
  void write(BinaryWriter writer, SkullkingGame obj) {
    writer.writeList(obj.players);
    writer.writeInt(obj.currentRound);
    writer.writeBool(obj.isFinished());
    writer.writeInt(obj.getStartTime().millisecondsSinceEpoch);
    writer.writeString(obj.mode.name);
    writer.writeString(obj.rules.name);
    writer.writeBool(obj.lootCardsPresent);
    writer.writeBool(obj.advancedPirateAbilitiesEnabled);
    writer.writeBool(obj.additionalBonuses);
    writer.writeList(obj.rounds);
  }
}
