class LevelData {
  final bool fakeFloor;
  final bool fakeGoal;

  LevelData({
    required this.fakeFloor,
    required this.fakeGoal,
  });
}

final List<LevelData> levels = List.generate(
  10,
  (i) => LevelData(
    fakeFloor: i % 2 == 0,
    fakeGoal: i % 3 == 0,
  ),
);
