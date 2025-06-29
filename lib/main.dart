import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme/zaytooon_theme.dart';
import 'providers/user_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_confirmation_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/location_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ],
      child: const ZaytooonApp(),
    ),
  );
}

class ZaytooonApp extends StatelessWidget {
  const ZaytooonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'زيتون Zaytooon',
      debugShowCheckedModeBanner: false,
      theme: ZaytooonTheme.theme,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar', ''), // Arabic
        Locale('en', ''), // English
      ],
      localizationsDelegates: const [
        // أضف ديليجات اللغات الأساسية هنا
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // إذا عندك ديليجيت خاص بك أضفه هنا (مثلا: AppLocalizations.delegate)
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/details': (context) => const MealDetailsScreen(),
        '/cart': (context) => const CartScreen(),
        '/order_confirmation': (context) => const OrderConfirmationScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/location': (context) => const LocationScreen(),
      },
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}