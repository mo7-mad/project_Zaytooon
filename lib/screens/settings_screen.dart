import 'package:flutter/material.dart';
import '../theme/zaytooon_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      backgroundColor: ZaytooonTheme.background,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: ZaytooonTheme.primary),
            title: const Text('اللغة'),
            subtitle: const Text('العربية'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info, color: ZaytooonTheme.secondary),
            title: const Text('عن التطبيق'),
            subtitle: const Text('تطبيق زيتون - مع زيتون الجوع يهون'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone_android, color: ZaytooonTheme.secondary),
            title: const Text('الدعم الفني'),
            subtitle: const Text('تواصل معنا لأي مشكلة أو استفسار'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: ZaytooonTheme.accent),
            title: const Text('سياسة الخصوصية'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star_rate, color: Colors.amber),
            title: const Text('قيّم التطبيق'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}