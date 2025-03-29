import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/order.dart';
import 'package:kilimboga/data/product.dart';


class ProductProvider with ChangeNotifier {
  ProductProvider() {
    initOrders();
  }

  Map<Product, int> _cartproducts = {};
  final List<Product> _popularProducts = [];

  bool _isLoading = false;

  int quantity = 1;
  Map<Payment, String> _payment = {Payment.paypal: ""};

  double _totalamount = 0;
  double _discount = 0;
  double _amount = 0;
  double _transport = 0;

  List<Order> _orders = [];
  bool get isLoading => _isLoading;
  List<Order> get orders => _orders;

  double get totalamount => _totalamount;
  double get discount => _discount;
  double get amount => _amount;
  double get transport => _transport;
  List<Product> get popularProducts => _popularProducts;

  Map<Product, int> get cartproducts => _cartproducts;
  Map<Payment, String> get payment => _payment;

  Future<void> initOrders() async {
    _isLoading = true;
    notifyListeners();

    try {

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      throw Exception("An error occurred : $e");
    }
  }

  void addToCart(Product product, int quantity) {
    _cartproducts.clear();
    Map<Product, int> newProduct = {product: quantity};
    _cartproducts.addEntries(newProduct.entries);

    calculateTotal();

    notifyListeners();
  }

  void calculateTotal() {
    _isLoading = true;
    notifyListeners();
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

  void createOrder(List<Product> product, double amount) {
    final Random random = Random();
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

    String orderId =
        List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();

    _isLoading = true;
    notifyListeners();
    try {
      _orders.add(Order(
        orderId: orderId,
        userId: "user_001",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: Status.pending,
        products: product,
        totalAmount: amount,
        latitude: -1.286389,
        longitude: 36.817223,
        payment: _payment,
      ));

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to add product to orders");
    }
    _isLoading = false;

    notifyListeners();
  }

  void createSingleOrder(Product product, int quantity) {
    calculateTotal();
    final Random random = Random();
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

    String orderId =
        List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();

    _isLoading = true;
    notifyListeners();

    try {
      _orders.add(Order(
          orderId: orderId,
          userId: "user_001",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: Status.pending,
          products: [product],
          totalAmount: totalamount,
        latitude: -1.286389,
        longitude: 36.817223,
          payment: _payment));

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to add product to orders");
    }
    _isLoading = false;

    notifyListeners();
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

  Product fetchProduct(String productId) {
    _isLoading = true;
    notifyListeners();

    Product product =
        products.firstWhere((product) => product.productId == productId);

    _isLoading = false;
    notifyListeners();

    return product;
  }
}
