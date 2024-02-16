class SkullkingPlayerRound {
  final int bids;
  final int won;
  final int standard14;
  final int black14;
  final int mermaids;
  final int pirates;
  final int skullking;
  final int loots;
  final int rascalBid;
  final int additionalBonuses;

  const SkullkingPlayerRound({
    this.bids = 0,
    this.won = 0,
    this.standard14 = 0,
    this.black14 = 0,
    this.mermaids = 0,
    this.pirates = 0,
    this.skullking = 0,
    this.loots = 0,
    this.rascalBid = 0,
    this.additionalBonuses = 0,
  });
}

class SkullkingPlayerGame {
  final List<SkullkingPlayerRound> rounds;

  SkullkingPlayerGame(int nbRounds) : rounds = List.filled(nbRounds, const SkullkingPlayerRound());

  SkullkingPlayerGame._(this.rounds);

  SkullkingPlayerRound getRound(int index) => rounds[index];

  void changeRound(int index, SkullkingPlayerRound round) {
    rounds[index] = round;
  }

  static SkullkingPlayerGame fromDatasource({required List<SkullkingPlayerRound> rounds}) => SkullkingPlayerGame._(rounds);
}
