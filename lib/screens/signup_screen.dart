import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../providers/user_provider.dart';

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
  final _codeController = TextEditingController();

  bool _emailVerified = false;
  String? _verificationCode;
  bool _loading = false;
  String? _errorMsg;

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
                setState(() => _emailVerified = true);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم التحقق من البريد الإلكتروني بنجاح!")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("الكود غير صحيح. حاول مجددًا.")),
                );
              }
            },
            child: const Text("تأكيد"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("إلغاء"),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _errorMsg = null;
    });
    if (!_emailVerified) {
      _showVerificationDialog();
      return;
    }
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMsg = "كلمتا المرور غير متطابقتين";
        });
        return;
      }
      setState(() {
        _loading = true;
      });
      try {
        await Provider.of<UserProvider>(context, listen: false).register(
          username: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        setState(() {
          _errorMsg = e.toString().replaceAll('Exception: ', '');
        });
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
                      Image.asset('assets/images/zaytooon_logo.png', height: 80),
                      const SizedBox(height: 12),
                      const Text(
                        "إنشاء حساب جديد",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B9821),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'أدخل الاسم الكامل' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'أدخل البريد الإلكتروني' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'رقم الجوال'),
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'أدخل رقم الجوال' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'كلمة المرور'),
                        obscureText: true,
                        validator: (v) => v == null || v.length < 6
                            ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
                        obscureText: true,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'أدخل تأكيد كلمة المرور' : null,
                      ),
                      const SizedBox(height: 18),
                      if (_errorMsg != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            _errorMsg!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _submit,
                          child: _loading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('تسجيل'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("لديك حساب؟"),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                            child: const Text('تسجيل الدخول'),
                          ),
                        ],
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