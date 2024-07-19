import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/field.dart';

part 'player_edition_state.freezed.dart';

@freezed
class PlayerEditionState with _$PlayerEditionState {
  const PlayerEditionState._();

  const factory PlayerEditionState({required Field<String> name}) = _PlayerEditionState;

  factory PlayerEditionState.empty() => const PlayerEditionState(name: Field(value: ''));

  bool isValid() => name.isValid;
}
