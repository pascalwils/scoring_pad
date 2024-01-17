import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scoring_pad/data/players/players_notifier.dart';

import '../../../domain/entities/player.dart';
import '../../../common/field/field.dart';
import 'player_edition_state.dart';

class PlayerEditionDialogNotifier extends StateNotifier<PlayerEditionState> {
  final List<Player>? players;

  PlayerEditionDialogNotifier(this.players) : super(PlayerEditionState.empty());

  void setName(String name) {
    late Field<String> nameField;
    if (name.isEmpty) {
      nameField = state.name.copyWith(value: name, errorMessage: null, isValid: false);
    } else if (players != null && !players!.any((e) => e.name == name)) {
      nameField = state.name.copyWith(value: name, errorMessage: null, isValid: true);
    } else {
      nameField = state.name.copyWith(
        value: name,
        errorMessage: 'Enter a valid name',
        isValid: false,
      );
    }
    state = state.copyWith(name: nameField);
  }
}

final playerEditionDialogNotifierProvider = StateNotifierProvider.autoDispose<PlayerEditionDialogNotifier, PlayerEditionState>(
  (ref) {
    return PlayerEditionDialogNotifier(ref.read(playersProvider).players);
  },
);
