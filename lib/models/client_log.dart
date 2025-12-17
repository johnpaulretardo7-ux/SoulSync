import 'package:hive/hive.dart';

part 'client_log.g.dart';

@HiveType(typeId: 0)
class ClientLog extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int moodScore;

  @HiveField(2)
  final List<String> emotions;

  @HiveField(3)
  final List<String> influences;

  @HiveField(4)
  final List<String> physicalSensation;

  @HiveField(5)
  final List<String> wellbeingActions;

  @HiveField(6)
  final String endOfDayNote;

  @HiveField(7)
  final DateTime timestamp;

  ClientLog({
    required this.name,
    required this.moodScore,
    required this.emotions,
    required this.influences,
    required this.physicalSensation,
    required this.wellbeingActions,
    required this.endOfDayNote,
    required this.timestamp,
  });
}
