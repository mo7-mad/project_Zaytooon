import 'package:flutter/material.dart';
import '../theme/zaytooon_theme.dart';

final List<Map<String, dynamic>> meals = [
  {
    "name": "برجر دجاج",
    "img": "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=400&q=80",
    "price": 18,
    "desc": "برجر دجاج طازج مع صوص خاص وخس.",
    "category": "وجبات",
  },
  {
    "name": "بيتزا مارجريتا",
    "img": "https://images.unsplash.com/photo-1542281286-9e0a16bb7366?auto=format&fit=crop&w=400&q=80",
    "price": 30,
    "desc": "بيتزا إيطالية بالجبن والطماطم الطازجة.",
    "category": "وجبات",
  },
  {
    "name": "عصير برتقال طازج",
    "img": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80",
    "price": 10,
    "desc": "عصير برتقال طبيعي ومنعش.",
    "category": "مشروبات",
  },
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
        tooltip: 'السلة',
        child: const Icon(Icons.shopping_cart),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "الأصناف",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ZaytooonTheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          ...meals.map((meal) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      meal['img'] as String,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    meal['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ZaytooonTheme.darkText,
                    ),
                  ),
                  subtitle: Text(
                    meal['desc'],
                    style: const TextStyle(color: ZaytooonTheme.darkText),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ZaytooonTheme.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/details', arguments: meal),
                    child: const Text('اطلب'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}