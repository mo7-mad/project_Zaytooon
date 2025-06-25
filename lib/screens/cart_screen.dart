import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية للسلة
    final List<Map<String, dynamic>> cartItems = [
      {
        "name": "برجر دجاج",
        "price": 18,
        "img": "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=400&q=80",
        "qty": 2
      },
      {
        "name": "عصير برتقال",
        "price": 10,
        "img": "https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80",
        "qty": 1
      },
    ];

    final int total = cartItems.fold(
      0,
      (sum, item) => sum + (item["price"] as int) * (item["qty"] as int),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('سلة الطلبات')),
      backgroundColor: const Color(0xFFF8FFF2),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cartItems.map((item) => ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item["img"], width: 48),
                ),
                title: Text(item["name"]),
                subtitle: Text('الكمية: ${item["qty"]}'),
                trailing: Text(
                  '${item["price"] * item["qty"]} ج.م',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF388E3C)),
                ),
              )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "الإجمالي:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      '$total ج.م',
                      style: const TextStyle(
                        color: Color(0xFFE53935),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF388E3C),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم إرسال الطلب!")),
                      );
                    },
                    child: const Text('تأكيد الطلب', style: TextStyle(fontSize: 18)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}