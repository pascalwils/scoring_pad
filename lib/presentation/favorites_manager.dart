import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/game_type.dart';

class FavoriteManager extends Notifier<List<GameType>> {
  @override
  List<GameType> build() {
    return List<GameType>.empty();
  }

  void add(GameType entry) {
    if (!state.contains(entry)) {
      state = [...state, entry];
    }
  }

  void remove(GameType entry) {
    if (state.contains(entry)) {
      state = [...state.where((element) => element != entry)];
    }
  }
}
