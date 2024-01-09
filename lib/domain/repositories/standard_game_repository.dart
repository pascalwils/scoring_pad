import '../entities/standard_game.dart';

abstract class StandardGameRepository {
  bool addGame(StandardGame game);
  bool removeGame(StandardGame game);
  List<StandardGame> getAllGames();
}
