import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../domain/entities/game_type.dart';
import '../../domain/repositories/favorite_repository.dart';
import 'favorite_state.dart';
import 'in_memory_favorite_repository.dart';

final talker = Talker();

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final FavoriteRepository _repository;

  FavoriteNotifier(this._repository) : super(const FavoriteState.initial()) {
    _updateState();
  }

  Future<void> addFavorite(GameType entry) async {
    try {
      await _repository.add(entry);
      _updateState();
    } catch (e) {
      talker.debug("Unable to add favorite '$entry' in repository", e);
    }
  }

  Future<void> removeFavorite(GameType entry) async {
    try {
      await _repository.remove(entry);
      _updateState();
    } catch (e) {
      talker.debug("Unable to remove favorite '$entry' in repository", e);
    }
  }

  void _updateState() async {
    try {
      final favorites = await _repository.getAllFavorites();
      state = state.copyWith(favorites: favorites);
    } catch (e) {
      talker.debug("Unable to get all favorites from repository", e);
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoriteNotifier, FavoriteState>(
      (ref) {
    final repository = ref.watch(favoriteRepositoryProvider);
    return FavoriteNotifier(repository);
  },
);
