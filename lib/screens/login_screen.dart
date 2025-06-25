import 'package:flutter/material.dart';
import '../theme/zaytooon_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZaytooonTheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/zaytooon_logo.png', height: 80), // ضع شعار زيتون هنا
                      const SizedBox(height: 12),
                      const Text(
                        "تسجيل الدخول إلى زيتون",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ZaytooonTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // الجملة الدعائية
                      const Text(
                        "مع زيتون الجوع يهون",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ZaytooonTheme.accent,
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (v) => email = v,
                        validator: (v) => v!.isEmpty ? 'أدخل البريد الإلكتروني' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'كلمة المرور'),
                        obscureText: true,
                        onSaved: (v) => password = v,
                        validator: (v) => v!.isEmpty ? 'أدخل كلمة المرور' : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: const Text('دخول'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("ليس لديك حساب؟"),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/signup'),
                            child: const Text('إنشاء حساب'),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.email),
                          label: const Text('تسجيل الدخول عبر الإيميل'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ميزة قيد التطوير")));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}