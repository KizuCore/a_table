import 'package:isar/isar.dart';
part 'food_item.g.dart';

// Emplacement de stockage
@embedded
class StorageLocation {
  // "fridge" | "freezer" | "pantry"
  late String value;
}

// Entité principale d'inventaire
@collection
class FoodItem {
  // Identifiant auto-incrémenté
  Id id = Isar.autoIncrement;

  // Nom de l'aliment (ex: Champignon de Paris)
  late String name;

  // Catégorie facultative
  int? categoryId; // FK vers Category.id

  // Quantité et unité (unités simples)
  double quantity = 1;
  String unit = 'piece'; // piece | g | ml

  // Emplacement (frigo/congélateur/placard)
  StorageLocation location = StorageLocation()..value = 'fridge';

  // Dates
  DateTime? purchaseDate;
  DateTime? expiryDate; // date de péremption si connue

  // Gestion ouverture
  DateTime? openedAt;
  int? shelfLifeAfterOpenDays; // durée de vie après ouverture en jours

  // Notes libres
  String? notes;

  // Index utiles
  @Index()
  DateTime? get expirySortKey => expiryDate ?? DateTime(2100);

  @Index()
  int? get catIndex => categoryId;
}