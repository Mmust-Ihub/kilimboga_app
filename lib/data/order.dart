
import 'package:kilimboga/data/product.dart';

enum Status { pending, completed, cancelled }

enum Payment {
  paypal,
  mpesa,
}

class Order {
  final String orderId;
  final String userId;
  final double latitude;
  final double longitude;
  final List<Product> products;
  final double totalAmount;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<Payment,String> payment;

  Order({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
    required this.payment ,
  });
}
