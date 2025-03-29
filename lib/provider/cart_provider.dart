import 'package:flutter/material.dart';
import 'package:kilimboga/data/cart.dart';
import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/product.dart';


class CartProvider with ChangeNotifier {
  // final User currentUser = user;
  Map<Product, int> _cartproducts = {};

  double _totalamount = 0;
  double _discount = 0;
  double _amount = 0;
  double _transport = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Cart? _cart;
  Cart? get cart => _cart;
  double get totalamount => _totalamount;
  double get discount => _discount;
  double get amount => _amount;
  double get transport => _transport;

  Map<Product, int> get cartproducts => _cartproducts;

  CartProvider() {
    initCart();
  }

  Future<void> initCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cart = carts.firstWhere((cart) => cart.userId == "user_001",
          orElse: () => Cart(
                cartId: 'empty_cart',
                userId: "user_001",
                products: {},
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ));

      _cartproducts = _cart?.products ?? {};

      _isLoading = false;

      calculateTotal();

      notifyListeners();
    } catch (e) {
      throw Exception("An error occurred : $e");
    }
  }

  void calculateTotal() {
    _amount = 0;
    _discount = 0;
    _transport = 0;
    _totalamount = 0;
    for (var entry in _cartproducts.entries) {
      Product product = entry.key;
      int quantity = entry.value;
      _amount += product.price * quantity;

      _transport = 0.075 * _amount;

      if (_amount > 1000) {
        _discount = 0.025 * _amount;
      }

      _totalamount = _amount + _transport - _discount;
    }
  }

  void deleteItem(Product item) {
    if (_cartproducts.containsKey(item)) {
      _cartproducts.remove(item);

      notifyListeners();

      calculateTotal();

      notifyListeners();
    }
  }

  int addToCart(Product product,int quantity) {
    if (!_cartproducts.containsKey(product)) {
      Map<Product, int> newProduct = {product: quantity};
      _cartproducts.addEntries(newProduct.entries);

      calculateTotal();

    notifyListeners();
      return 200;
    } else {
      return 400;
    }

    
  }

  void increment(MapEntry<Product, int> entry) {
    Product product = entry.key;
    if (_cartproducts.containsKey(product)) {
      _cartproducts[product] = _cartproducts[product]! + 1;
    } else {
      throw Exception('Product does not exist: ');
    }
    notifyListeners();

    calculateTotal();

    notifyListeners();
  }

  void decrement(MapEntry<Product, int> entry) {
    Product product = entry.key;
    int quantity = entry.value;

    if (_cartproducts.containsKey(product)) {
      quantity > 1
          ? _cartproducts[product] = _cartproducts[product]! - 1
          : _cartproducts[product] = 1;
    } else {
      throw Exception('Product does not exist: ');
    }
    notifyListeners();

    calculateTotal();

    notifyListeners();
  }
}
