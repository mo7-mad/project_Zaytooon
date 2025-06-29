import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/zaytooon_theme.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: ZaytooonTheme.primary,
              size: 70,
            ),
            const SizedBox(height: 24),
            const Text(
              'تم استلام طلبك بنجاح!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ZaytooonTheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              'إجمالي المبلغ: ${cartProvider.totalPrice} ر.س',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            const Text(
              'سيتم التواصل معك قريباً لتأكيد تفاصيل التوصيل.',
              style: TextStyle(fontSize: 18, color: ZaytooonTheme.darkText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ZaytooonTheme.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.home),
              label: const Text('العودة للرئيسية'),
              onPressed: () {
                cartProvider.clearCart();
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}