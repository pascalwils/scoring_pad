enum GameType {
  papayoo(73365),
  prophecy(373435),
  take5(432),
  skullking(150145);

  const GameType(this.id);

  final num id;

  static GameType? fromString(String name) {
    try {
      return GameType.values.firstWhere((e) => e.name == name);
    }
    on StateError {
      return null;
    }
  }
}
