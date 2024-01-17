import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/game_type.dart';
import '../../domain/repositories/favorite_repository.dart';

final talker = Talker();

class InMemoryFavoriteRepository implements FavoriteRepository {
  final List<GameType> _favorites = List<GameType>.empty(growable: true);

  @override
  Future<void> add(GameType entry) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!_favorites.contains(entry)) {
      _favorites.add(entry);
      talker.debug("Add favorite '$entry' to database.");
    }
  }

  @override
  Future<bool> remove(GameType entry) async {
    await Future.delayed(const Duration(milliseconds: 100));
    talker.debug("Remove favorite '$entry' from database.");
    return _favorites.remove(entry);
  }

  @override
  Future<List<GameType>> getAllFavorites() async {
    await Future.delayed(const Duration(milliseconds: 100));
    talker.debug("Get all players.");
    return _favorites;
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>(
      (ref) {
    return InMemoryFavoriteRepository();
  },
);
