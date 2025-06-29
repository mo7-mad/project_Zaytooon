import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/zaytooon_theme.dart';
import '../providers/cart_provider.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int qty = 1;
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? meal =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (meal == null) {
      return const Scaffold(body: Center(child: Text('لا يوجد بيانات للوجبة')));
    }

    return Scaffold(
      backgroundColor: ZaytooonTheme.background,
      appBar: AppBar(
        title: Text(meal['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  meal['img'],
                  height: 180,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              meal['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: ZaytooonTheme.primary,
              ),
            ),
            Text(
              meal['desc'],
              style: const TextStyle(fontSize: 16, color: ZaytooonTheme.darkText),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.attach_money, color: ZaytooonTheme.secondary),
                const SizedBox(width: 6),
                Text(
                  '${meal['price']} ريال',
                  style: const TextStyle(
                      color: ZaytooonTheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Text('الكمية:', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: qty > 1 ? () => setState(() => qty--) : null,
                ),
                Text('$qty', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => qty++),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ZaytooonTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(
                  addedToCart ? 'تمت الإضافة!' : 'أضف للسلة',
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: addedToCart
                    ? null
                    : () {
                        Provider.of<CartProvider>(context, listen: false).addToCart({
                          'name': meal['name'],
                          'img': meal['img'],
                          'price': meal['price'],
                          'qty': qty,
                        });
                        setState(() => addedToCart = true);
                        Future.delayed(const Duration(milliseconds: 1200), () {
                          if (mounted) {
                            setState(() => addedToCart = false);
                          }
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}