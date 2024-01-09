import 'package:scoring_pad/domain/entities/skullking/skullking_game.dart';

abstract class SkullkingGameRepository {
  bool addGame(SkullkingGame game);
  bool removeGame(SkullkingGame game);
  List<SkullkingGame> getAllGames();
}
