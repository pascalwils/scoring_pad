import '../../../common/field.dart';

class PlayerEditionState {
  final Field<String> name;

  const PlayerEditionState({required this.name});

  factory PlayerEditionState.empty() => const PlayerEditionState(name: Field(value: ''));

  PlayerEditionState copyWith({Field<String>? name}) => PlayerEditionState(name: name ?? this.name);

  bool isValid() => name.isValid;
}
