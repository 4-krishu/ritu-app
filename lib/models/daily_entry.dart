import 'package:hive/hive.dart';

part 'daily_entry.g.dart';

@HiveType(typeId: 0)
class DailyEntry {
  @HiveField(0)
  final String date; // yyyy-MM-dd

  @HiveField(1)
  String morningText;

  @HiveField(2)
  String nightText;

  DailyEntry({
    required this.date,
    this.morningText = '',
    this.nightText = '',
  });
}
