import '../entities/game_type.dart';

abstract class FavoriteRepository {
  Future<void> add(GameType entry);
  Future<void> remove(GameType entry);
  Future<List<GameType>> getAllFavorites();
}
