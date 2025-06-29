import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;
  final String? customerName;
  final DateTime? estimatedDelivery;
  final List<Map<String, dynamic>>? orderItems;

  const OrderConfirmationScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmount,
    this.customerName,
    this.estimatedDelivery,
    this.orderItems,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = estimatedDelivery != null
        ? "${estimatedDelivery!.day}/${estimatedDelivery!.month}/${estimatedDelivery!.year} ${estimatedDelivery!.hour}:${estimatedDelivery!.minute.toString().padLeft(2, '0')}"
        : "سيتم التواصل معك لتأكيد وقت التوصيل";

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد الطلب'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 16),
            Text(
              'تم تأكيد طلبك بنجاح!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (customerName != null)
              Text(
                'شكرًا لك، $customerName!',
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.confirmation_number, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('رقم الطلب: $orderNumber',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('موعد التوصيل المتوقع: $formattedDate',
                          style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (orderItems != null && orderItems!.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerRight,
                child: Text('ملخص الطلب:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderItems!.length,
                itemBuilder: (context, idx) {
                  final item = orderItems![idx];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[100],
                      child: Text('${item['qty']}'),
                    ),
                    title: Text(item['name'] ?? ''),
                    trailing: Text('${item['price']} ج.م', style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
              const Divider(height: 32),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المجموع الكلي:', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                Text('${totalAmount.toStringAsFixed(2)} ج.م', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'سيتم التواصل معك قريبًا من خلال خدمة العملاء لتأكيد تفاصيل الطلب والتوصيل. إذا واجهت أي مشكلة يرجى التواصل معنا.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              icon: const Icon(Icons.home),
              label: const Text('العودة للرئيسية', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('قريبًا سيتم تفعيل تتبع الطلب!')),
                );
              },
              icon: const Icon(Icons.delivery_dining_outlined),
              label: const Text('تتبع الطلب'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal),
              ),
              onPressed: () {
                final shareText = 'شكراً لطلبك من زيتون!\n'
                    'رقم الطلب: $orderNumber\n'
                    'المبلغ الكلي: ${totalAmount.toStringAsFixed(2)} ج.م\n'
                    '${orderItems != null ? 'المنتجات:\n${orderItems!.map((e) => '- ${e['name']} (${e['qty']})').join('\n')}\n' : ''}'
                    'تابعنا لمعرفة كل جديد!';
                // يمكنك استخدام حزمة share_plus لمشاركة النص
                // Share.share(shareText);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ميزة المشاركة تحتاج إضافة مكتبة share_plus')),
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('مشاركة تفاصيل الطلب'),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
                  Text('هل لديك سؤال أو مشكلة؟', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('يمكنك التواصل معنا عبر واتساب أو الهاتف:'),
                  SizedBox(height: 6),
                  SelectableText('واتساب: 0912345678\nهاتف: 0123456789', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '🎁 كوبون خصم: ZAYTOON10\nاستخدمه في طلبك القادم!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}