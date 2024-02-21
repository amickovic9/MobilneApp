import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    ["Avocado", "4.00", "lib/images/avocado.png", Colors.green],
    ["Banana", "2.50", "lib/images/banana.png", Colors.yellow],
    ["Chicken", "12.80", "lib/images/chicken.png", Colors.brown],
    ["Water", "1.00", "lib/images/water.png", Colors.blue],
    ["Strawberries", "5.00", "lib/images/strawberries.png", Colors.red],
    ["Broccoli", "3.50", "lib/images/broccoli.png", Colors.green],
    ["Carrot", "1.20", "lib/images/carrot.png", Colors.orange],
    ["Eggplant", "2.80", "lib/images/eggplant.png", Colors.purple],
    ["Tomato", "1.50", "lib/images/tomato.png", Colors.red],
    ["Lettuce", "2.00", "lib/images/lettuce.png", Colors.green],
    ["Milk", "3.00", "lib/images/milk.png", Colors.white],
    ["Bread", "2.50", "lib/images/bread.png", Colors.brown],
    ["Cheese", "4.50", "lib/images/cheese.png", Colors.yellow],
    ["Apple", "2.00", "lib/images/apple.png", Colors.red],
    ["Grapes", "4.50", "lib/images/grapes.png", Colors.purple],
    ["Orange", "1.80", "lib/images/orange.png", Colors.orange],
    ["Potato", "2.20", "lib/images/potato.png", Colors.brown],
    ["Onion", "1.00", "lib/images/onion.png", Colors.white],
    ["Cucumber", "1.50", "lib/images/cucumber.png", Colors.green],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
