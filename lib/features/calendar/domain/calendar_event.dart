import 'package:isar/isar.dart';
part 'calendar_event.g.dart';

@collection
class CalendarEvent {
  Id id = Isar.autoIncrement;

  // type: expiryWarning | recipePlan
  late String type;

  // Horodatage de l’événement
  late DateTime dateTime;

  // Charge utile sérialisée (id d’un FoodItem, d’une recette, etc.)
  String? payloadJson;

  bool isDone = false;

  @Index()
  DateTime get sortKey => dateTime;
}