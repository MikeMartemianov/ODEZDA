import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/clothing_item.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ClothingItemAdapter());
  await Hive.openBox<ClothingItem>('items');

  runApp(const ClosetTrackerApp());
}

class ClosetTrackerApp extends StatelessWidget {
  const ClosetTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closet Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomePage(),
    );
  }
}