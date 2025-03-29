

import 'package:kilimboga/data/product.dart';

class Cart {
  final String cartId;
  final String userId;
  final Map<Product, int> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.cartId,
    required this.userId,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });
}
