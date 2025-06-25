import 'package:flutter/material.dart';
import '../theme/zaytooon_theme.dart';

final List<Map<String, dynamic>> meals = [
  // ... عناصر الوجبات والمشروبات ...
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZaytooonTheme.background,
      appBar: AppBar(
        title: const Text('زيتون'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        child: const Icon(Icons.shopping_cart),
        tooltip: 'السلة',
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ... باقي الكود ...
        ],
      ),
    );
  }
}