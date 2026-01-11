import 'package:hive/hive.dart';

part 'private_note.g.dart';

@HiveType(typeId: 1)
class PrivateNote {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime createdAt;

  PrivateNote({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
