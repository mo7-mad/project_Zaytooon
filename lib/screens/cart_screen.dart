import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> initialCartItems;
  const CartScreen({super.key, this.initialCartItems = const []});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List<Map<String, dynamic>>.from(widget.initialCartItems);
  }

  int get total => cartItems.fold(
      0, (sum, item) => sum + (item["price"] as int) * (item["qty"] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة الطلبات')),
      backgroundColor: const Color(0xFFF8FFF2),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('السلة فارغة'))
                : ListView(
                    children: cartItems.map((item) => ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(item["img"], width: 48),
                          ),
                          title: Text(item["name"]),
                          subtitle: Text('الكمية: ${item["qty"]}'),
                          trailing: Text(
                            '${item["price"] * item["qty"]} ج.م',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF388E3C),
                            ),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    onPressed: cartItems.isEmpty
                        ? null
                        : () async {
                            String summary = cartItems
                                .map((item) => "${item['qty']} ${item['name']}")
                                .join(" و ");

                            bool? confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('تأكيد الطلب'),
                                content: Text(
                                  'أنت على وشك طلب: $summary\nهل أنت متأكد من متابعة الطلب؟',
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('إلغاء'),
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                  ),
                                  ElevatedButton(
                                    child: const Text('تأكيد'),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderConfirmationScreen(
                                    orderNumber: "12345",
                                    totalAmount: total.toDouble(),
                                    customerName: "ضيفنا العزيز",
                                    estimatedDelivery: DateTime.now()
                                        .add(const Duration(hours: 1)),
                                    orderItems: cartItems,
                                  ),
                                ),
                              );
                            }
                          },
                    child: const Text('تأكيد الطلب',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}