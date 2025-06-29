import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/zaytooon_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.account_circle, size: 64, color: ZaytooonTheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    userProvider.username ?? 'مستخدم',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userProvider.email ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  if (userProvider.phone != null)
                    Text(
                      userProvider.phone!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.language, color: ZaytooonTheme.secondary),
            title: const Text('اللغة'),
            subtitle: const Text('العربية'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('التطبيق يدعم العربية فقط حالياً')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: ZaytooonTheme.secondary),
            title: const Text('عن زيتون'),
            subtitle: const Text('تطبيق طلبات الطعام بخدمة سريعة واحترافية.\nإصدار 1.0.0'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('تأكيد الخروج'),
                  content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('تأكيد')),
                  ],
                ),
              );
              if (confirm == true) {
                await userProvider.logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}