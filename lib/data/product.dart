class Product {
  final String productId;
  final String restaurantId;
  final String name;
  final String logo;
  final String image;
  final double price;
  final String description;
  final double ratings;
  final List<String> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.productId,
    required this.restaurantId,
    required this.name,
    required this.logo,
    required this.image,
    required this.price,
    required this.description,
    required this.ratings,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
  });
}
