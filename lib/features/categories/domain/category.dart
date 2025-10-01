import 'package:isar/isar.dart';
part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;
  late String name; // ex: Champignon, Légumes, Produits laitiers
  String? icon;     // code d’icône facultatif
  int? parentId;    // pour sous-catégories si besoin
}