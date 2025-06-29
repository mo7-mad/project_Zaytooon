import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      // إذا العنصر موجود زود الكمية فقط
      final index = cartItems.indexWhere((e) => e['name'] == item['name']);
      if (index != -1) {
        cartItems[index]['qty'] += item['qty'];
      } else {
        cartItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zaytooon',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/home': (context) => HomeScreen(onAddToCart: addToCart),
        '/signup': (context) => const SignupScreen(),
        '/cart': (context) => CartScreen(initialCartItems: cartItems),
        '/settings': (context) => const SettingsScreen(),
      },
      initialRoute: '/home',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}