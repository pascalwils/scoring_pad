import '../entities/game_type.dart';

abstract class FavoriteRepository {
  Future<void> toggleFavorite(GameType entry);
  Future<List<GameType>> getAllFavorites();
}
