import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  /// للتحقق من البريد
  bool _emailVerified = false;
  String? _verificationCode;
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_emailVerified) {
      _showVerificationDialog();
      return;
    }
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_registered', true);
      await prefs.setString('user_name', _nameController.text);
      await prefs.setString('user_email', _emailController.text);
      await prefs.setString('user_phone', _phoneController.text);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  /// محاكاة إرسال كود تحقق للبريد (في التطبيق الحقيقي ترسل الكود بالبريد)
  void _sendVerificationCode() {
    String code = (Random().nextInt(899999) + 100000).toString();
    setState(() {
      _verificationCode = code;
    });
    // في التطبيق الحقيقي أرسل الكود عبر البريد الإلكتروني هنا
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم إرسال كود التحقق: $code (للتجربة، يظهر هنا فقط)")),
    );
  }

  void _showVerificationDialog() {
    _sendVerificationCode();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("تأكيد البريد الإلكتروني"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("أدخل كود التحقق الذي تم إرساله إلى بريدك الإلكتروني"),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "كود التحقق"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_codeController.text == _verificationCode) {
                setState(() => _emailVerified = true);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم التحقق من البريد الإلكتروني بنجاح!")),
                );
                _submit(); // أكمل التسجيل الآن
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("كود التحقق غير صحيح!")),
                );
              }
            },
            child: const Text("تأكيد"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: Center(
        child: SingleChildScrollView(
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
                    const Text('سجل بياناتك للمتابعة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'الاسم الرباعي'),
                      validator: (v) => v == null || v.trim().split(' ').length < 4 ? 'يرجى إدخال الاسم الرباعي' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v == null || !v.contains('@') ? 'يرجى إدخال بريد إلكتروني صحيح' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.trim().length < 8 ? 'يرجى إدخال رقم هاتف صحيح' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'كلمة المرور'),
                      obscureText: true,
                      validator: (v) => v != null && v.length >= 6 ? null : 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
                      obscureText: true,
                      validator: (v) => v == _passwordController.text ? null : 'كلمتا المرور غير متطابقتين',
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('تسجيل'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}