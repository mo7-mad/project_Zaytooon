import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback? onRegister;
  const SignupScreen({super.key, this.onRegister});

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
  final _codeController = TextEditingController();

  String? _verificationCode;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_registered', true);
      await prefs.setString('user_name', _nameController.text);
      await prefs.setString('user_email', _emailController.text);
      await prefs.setString('user_phone', _phoneController.text);

      if (!mounted) return;
      widget.onRegister?.call();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _sendVerificationCode() {
    String code = (Random().nextInt(899999) + 100000).toString();
    setState(() {
      _verificationCode = code;
    });
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
            const Text("أدخل كود التحقق الذي تم إرساله إلى بريدك الإلكتروني"),
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
                Navigator.pop(context);
                _submit();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('الكود غير صحيح!')),
                );
              }
            },
            child: const Text("تحقق"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل حساب جديد')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                validator: (v) => v == null || v.trim().isEmpty ? 'يرجى إدخال الاسم' : null,
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
                  onPressed: _showVerificationDialog,
                  child: const Text('تسجيل'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}