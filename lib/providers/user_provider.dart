import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username;
  String? _email;
  String? _phone;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;

  UserProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('is_registered') ?? false;
    _username = prefs.getString('user_name');
    _email = prefs.getString('user_email');
    _phone = prefs.getString('user_phone');
    notifyListeners();
  }

  Future<void> register({
    required String username,
    required String email,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_registered', true);
    await prefs.setString('user_name', username);
    await prefs.setString('user_email', email);
    await prefs.setString('user_phone', phone);
    _isLoggedIn = true;
    _username = username;
    _email = email;
    _phone = phone;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // تحقق بسيط: إذا الإيميل موجود مسبقاً اعتبره صحيح
    final prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('user_email');
    if (storedEmail == email) {
      _isLoggedIn = true;
      _username = prefs.getString('user_name');
      _email = email;
      _phone = prefs.getString('user_phone');
      notifyListeners();
    } else {
      throw Exception("البريد الإلكتروني أو كلمة المرور غير صحيحة");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isLoggedIn = false;
    _username = null;
    _email = null;
    _phone = null;
    notifyListeners();
  }
}