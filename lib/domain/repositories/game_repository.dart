import 'package:scoring_pad/domain/entities/game.dart';

abstract class GameRepository {
  bool addGame(Game game);
  bool removeGame(Game game);
  List<Game> getAllGames();
}
