import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  int get totalPrice => _items.fold(
      0, (sum, item) => sum + (item['price'] as int) * (item['qty'] as int));

  void addToCart(Map<String, dynamic> item) {
    final index = _items.indexWhere((e) => e['name'] == item['name']);
    if (index != -1) {
      _items[index]['qty'] += item['qty'];
    } else {
      _items.add(Map<String, dynamic>.from(item));
    }
    notifyListeners();
  }

  void removeFromCart(String itemName) {
    _items.removeWhere((item) => item['name'] == itemName);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}