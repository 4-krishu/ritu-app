import 'package:hive/hive.dart';

class PrivateNoteService {
  static final _box = Hive.box('private_note');

  static String get headline => _box.get('headline', defaultValue: '');
  static String get body => _box.get('body', defaultValue: '');

  static void save(String headline, String body) {
    _box.put('headline', headline);
    _box.put('body', body);
  }
}
