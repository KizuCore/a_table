import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/inventory/domain/food_item.dart';
import '../../features/categories/domain/category.dart';
import '../../features/calendar/domain/calendar_event.dart';

class IsarService {
  static Isar? _instance;

  // Retourne une instance unique d'Isar (lazy)
  static Future<Isar> db() async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [FoodItemSchema, CategorySchema, CalendarEventSchema],
      directory: dir.path,
      inspector: false,
    );
    return _instance!;
  }
}