import 'package:equatable/equatable.dart';

import '../../domain/entities/player.dart';

class PlayersState extends Equatable {
  final List<Player> players;

  const PlayersState({required this.players});

  const PlayersState.initial({this.players = const []});

  PlayersState copyWith({List<Player>? players}) {
    return PlayersState(players: players ?? this.players);
  }

  @override
  List<Object> get props => [players];
}
