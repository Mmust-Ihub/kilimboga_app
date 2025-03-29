

import 'package:kilimboga/data/order.dart';
import 'package:kilimboga/data/product.dart';

class Restaurant {
  final String restaurantId;
  final String name;
  final double latitude;
  final double longitude;
  double distance;
  final String description;
  final String logo;
  final String image;
  final double ratings;
  final List<String> reviews;
  final List<Product> products;
  final List<Order> orders;
  final DateTime createdAt;
  final DateTime updatedAt;

  Restaurant({
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.logo,
    required this.image,
    required this.ratings,
    required this.reviews,
    required this.products,
    required this.orders,
    required this.createdAt,
    required this.updatedAt,
    this.distance = 0
  });
}
