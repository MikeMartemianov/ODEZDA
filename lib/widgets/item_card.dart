import 'dart:io';

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String lastWorn;
  final bool highlight;

  const ItemCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.lastWorn,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: highlight ? Colors.orange.shade100 : null,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.file(File(imagePath), width: 56, height: 56, fit: BoxFit.cover),
        title: Text(name),
        subtitle: Text('Last worn: $lastWorn'),
        trailing: highlight ? const Icon(Icons.warning, color: Colors.orange) : null,
      ),
    );
  }
}