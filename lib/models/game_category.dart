
enum GameCategory {
  dice,
  card,
  board,
  free;

  static GameCategory getFromString(String? value) => values.firstWhere((e) => e.name == value);
}
