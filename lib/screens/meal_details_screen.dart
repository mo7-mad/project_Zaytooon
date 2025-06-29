import 'package:flutter/material.dart';


class MealDetailsScreen extends StatefulWidget {
  final String name;
  final String img;
  final int price;

  const MealDetailsScreen({
    super.key,
    required this.name,
    required this.img,
    required this.price,
    required this.onAddToCart,
  });

  final void Function(Map<String, dynamic> item) onAddToCart;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(widget.img, height: 200),
            const SizedBox(height: 16),
            Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${widget.price} ج.م', style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (qty > 1) setState(() => qty--);
                  },
                ),
                Text('$qty', style: const TextStyle(fontSize: 20)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() => qty++);
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text('أضف إلى السلة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  widget.onAddToCart({
                    "name": widget.name,
                    "price": widget.price,
                    "img": widget.img,
                    "qty": qty,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت إضافة المنتج إلى السلة!')),
                  );
                  Navigator.pop(context); // العودة للشاشة السابقة
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}