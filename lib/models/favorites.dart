import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_type.dart';

part 'favorites.freezed.dart';

@freezed
class Favorites with _$Favorites {
  const Favorites._();
  const factory Favorites({required List<GameType> entries}) = _Favorites;

  factory Favorites.empty() {
    return const Favorites(entries: []);
  }

  bool isFavorite(GameType game) {
    return entries.contains(game);
  }
}
