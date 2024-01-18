import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import 'package:scoring_pad/domain/entities/player.dart';
import 'package:scoring_pad/domain/repositories/player_repository.dart';
import 'player_data_source.dart';

final talker = Talker();

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerDataSource _dataSource;

  PlayerRepositoryImpl(this._dataSource);

  @override
  Future<bool> addPlayer(Player player) async => _dataSource.addPlayer(player);

  @override
  Future<bool> removePlayer(Player player) async => _dataSource.removePlayer(player);

  @override
  Future<List<Player>> getAllPlayers() async => _dataSource.getAllPlayers();
}

final playerRepositoryProvider = Provider<PlayerRepository>(
  (ref) {
    final dataSource = ref.read(playerDataSourceProvider);
    return PlayerRepositoryImpl(dataSource);
  },
);
