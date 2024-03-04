import 'package:scoring_pad/domain/entities/game_player.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';
import 'package:scoring_pad/domain/entities/skullking/skullking_game_mode.dart';

SkullkingGame skullkingSimpleGameFixture() => SkullkingGame(
      players: [GamePlayer(name: "A", colorIndex: 0), GamePlayer(name: "B", colorIndex: 1)],
      mode: SkullkingGameMode.regular,
      rules: SkullkingRules.initial,
      currentRound: 1,
    );
