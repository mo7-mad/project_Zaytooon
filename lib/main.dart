import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/zaytooon_theme.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/settings_screen.dart';


void main() {
  runApp(const ZaytooonApp());
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
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/cart': (context) => const CartScreen(),
        '/details': (context) => const MealDetailsScreen(),
        '/settings': (context) => const SettingsScreen(),
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