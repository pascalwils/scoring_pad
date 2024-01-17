import 'package:equatable/equatable.dart';

import '../../domain/entities/game_type.dart';

class FavoriteState extends Equatable {
  final List<GameType> favorites;

  const FavoriteState({required this.favorites});

  const FavoriteState.initial({this.favorites = const []});

  FavoriteState copyWith({List<GameType>? favorites}) {
    return FavoriteState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object> get props => [favorites];
}
