import 'package:hive/hive.dart';
part 'clothing_item.g.dart';

@HiveType(typeId: 0)
class ClothingItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String imagePath;

  @HiveField(2)
  DateTime? lastWorn;

  ClothingItem({required this.name, required this.imagePath, this.lastWorn});
}