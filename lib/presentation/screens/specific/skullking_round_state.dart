enum SkullkingField { bid, won, standard14, black14, mermaids, pirates, skullking, loots, rascal, additionalBonuses }

class SkullkingRoundState {
  final Map<SkullkingField, int> fields;

  const SkullkingRoundState(this.fields);

  factory SkullkingRoundState.empty() => const SkullkingRoundState({});

  SkullkingRoundState copyWith({required SkullkingField field, required int value}) {
    final result = Map<SkullkingField, int>.from(fields);
    result[field] = value;
    return SkullkingRoundState(result);
  }
}
