import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool? isRegistered;

  @override
  void initState() {
    super.initState();
    checkRegistration();
  }

  Future<void> checkRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isRegistered = prefs.getBool('is_registered') ?? false;
    });
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      final index = cartItems.indexWhere((e) => e['name'] == item['name']);
      if (index != -1) {
        cartItems[index]['qty'] += item['qty'];
      } else {
        cartItems.add(item);
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // لا تذهب لبناء التطبيق إلا إذا isRegistered != null
    if (isRegistered == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      title: 'Zaytooon',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/home': (context) => HomeScreen(onAddToCart: addToCart),
        '/signup': (context) => SignupScreen(onRegister: () {
              setState(() {
                isRegistered = true;
              });
            }),
        '/cart': (context) => CartScreen(
              initialCartItems: cartItems,
              onRemove: removeFromCart,
              onClear: clearCart,
            ),
        '/settings': (context) => const SettingsScreen(),
      },
      initialRoute: isRegistered! ? '/home' : '/signup',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}