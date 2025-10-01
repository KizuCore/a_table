import 'package:isar/isar.dart';
import '../../../core/db/isar_service.dart';
import '../domain/food_item.dart';

class FoodRepository {
  // Récupère tous les items triés par date de péremption (lecture unique)
  Future<List<FoodItem>> getAll() async {
    final db = await IsarService.db();
    return db.foodItems.where().sortByExpirySortKey().findAll();
  }

  // ✅ Flux auto-actualisé des items (se met à jour dès qu'on ajoute/modifie/supprime)
  Stream<List<FoodItem>> watchAll() async* {
    final db = await IsarService.db();
    yield* db.foodItems
        .where()
        .sortByExpirySortKey()
        .watch(fireImmediately: true); // push immédiat + updates en temps réel
  }

  Future<void> insert(FoodItem item) async {
    final db = await IsarService.db();
    await db.writeTxn(() async {
      await db.foodItems.put(item);
    });
  }

  Future<void> update(FoodItem item) async {
    final db = await IsarService.db();
    await db.writeTxn(() async {
      await db.foodItems.put(item);
    });
  }

  Future<void> delete(Id id) async {
    final db = await IsarService.db();
    await db.writeTxn(() async {
      await db.foodItems.delete(id);
    });
  }
}
