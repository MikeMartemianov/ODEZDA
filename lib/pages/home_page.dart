import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/clothing_item.dart';
import '../widgets/item_card.dart';
import 'add_item_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<ClothingItem> box = Hive.box<ClothingItem>('items');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wardrobe'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<ClothingItem> items, _) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No items yet. Add one!'),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items.getAt(index);
              if (item == null) return const SizedBox.shrink();
              final lastWornStr = item.lastWorn != null
                  ? DateFormat.yMMMd().format(item.lastWorn!)
                  : 'Never';
              final bool overdue = item.lastWorn == null ||
                  DateTime.now().difference(item.lastWorn!).inDays > 30;
              return GestureDetector(
                onTap: () {
                  item.lastWorn = DateTime.now();
                  item.save();
                },
                child: ItemCard(
                  name: item.name,
                  imagePath: item.imagePath,
                  lastWorn: lastWornStr,
                  highlight: overdue,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddItemPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}