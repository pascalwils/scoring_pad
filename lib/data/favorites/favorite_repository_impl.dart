import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/game_type.dart';
import '../../domain/repositories/favorite_repository.dart';
import 'favorite_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource _dataSource;

  FavoriteRepositoryImpl(this._dataSource);

  @override
  Future<void> add(GameType entry) async => _dataSource.addFavorite(entry);

  @override
  Future<void> remove(GameType entry) async => _dataSource.removeFavorite(entry);

  @override
  Future<List<GameType>> getAllFavorites() async => _dataSource.getAllFavorites();
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>(
      (ref) {
    final dataSource = ref.read(favoriteDataSourceProvider);
    return FavoriteRepositoryImpl(dataSource);
  },
);
