import 'package:hive/hive.dart';
import '../models/daily_entry.dart';

class DiaryService {
  static final Box<DailyEntry> _box =
      Hive.box<DailyEntry>('daily_diary');

  /// Get entry for a date (yyyy-MM-dd)
  static DailyEntry getEntry(String date) {
    return _box.get(
      date,
      defaultValue: DailyEntry(date: date),
    )!;
  }

  /// Save morning text
  static void saveMorning({
    required String date,
    required String text,
  }) {
    final entry = getEntry(date);
    entry.morningText = text;
    _box.put(date, entry);
  }

  /// Save night text
  static void saveNight({
    required String date,
    required String text,
  }) {
    final entry = getEntry(date);
    entry.nightText = text;
    _box.put(date, entry);
  }
}
