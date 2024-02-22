import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<List<String>> _shopItems = [
    ['Jabuka', '150'],
    ['Banana', '80'],
    ['Paradajz', '200'],
    ['Krastavac', '120'],
    ['Pomorandže', '120'],
    ['Krompir', '60'],
    ['Luk', '40'],
    ['Jagode', '250'],
    ['Šargarepa', '100'],
    ['Kivi', '180'],
    ['Ananas', '300'],
    ['Brokoli', '150'],
    ['Trešnje', '200'],
    ['Tikvica', '90'],
    ['Limun', '100'],
    ['Maline', '300'],
    ['Kelj', '80'],
    ['Breskve', '180'],
    ['Artičoka', '250'],
    ['Zelena salata', '120'],
  ];

  List<List<String>> get shopItems => _shopItems;

  List<List<String>> _cartItems = [];

  List<List<String>> get cartItems => _cartItems;

  void addItemToCart(String name, double price) {
    _cartItems.add([name, price.toString()]);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += double.parse(item[1]);
    }
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
