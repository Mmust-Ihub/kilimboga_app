import 'dart:math';

import 'package:kilimboga/data/cart.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/data/order.dart';
import 'package:kilimboga/data/product.dart';

User? user;
Preuser? preuser;
String? fcm;

// User

final Random _random = Random();

List<Order> generateOrdersForRestaurant(
    String restaurantId, List<Product> restaurantProducts) {
  int orderCount = _random.nextInt(5) + 1; // Each restaurant gets 1-5 orders

  return List.generate(orderCount, (index) {
    Product randomProduct =
        restaurantProducts[_random.nextInt(restaurantProducts.length)];

    return Order(
      orderId: "order_${restaurantId}_${index + 1}",
      userId: "user_001",
      products: [randomProduct],
      totalAmount: randomProduct.price * (_random.nextInt(3) + 1),
      status: Status.values[_random.nextInt(Status.values.length)],
      createdAt: DateTime(
          2024, _random.nextInt(2) + 1, _random.nextInt(28) + 1, 18, 30),
      updatedAt: DateTime(2024, 2, _random.nextInt(7) + 1, 10, 10),
      latitude: -1.28 + (index * 0.002),
      longitude: 36.82 + (index * 0.003),
      payment: index % 2 == 0
          ? {Payment.paypal: "+254720041750"}
          : {Payment.mpesa: "+254720041750"},
    );
  });
}

// Products
final List<Product> products = List.generate(
    30,
    (index) => Product(
          productId: "prod_00${index + 1}",
          restaurantId: "rest_00${(index % 10) + 1}",
          name: "Product ${index + 1}",
          price: (500 + (index * 50)).toDouble(),
          description: "A delicious and mouth-watering meal option.",
          logo: index % 2 == 0
              ? "assets/images/phone.png"
              : "assets/images/laptop.png",
          image: "assets/images/shoes.png",
          ratings: 4.2 + (index % 3) * 0.1,
          reviews: ["Tasty!", "Would order again!", "Excellent flavor!"],
          createdAt: DateTime(2024, 1, 15 + (index % 5), 13, 15),
          updatedAt: DateTime(2024, 2, 6, 11, 20),
        ));

// Cart
final List<Cart> carts = [
  Cart(
    cartId: "cart_001",
    userId: "user_001",
    products: {
      products[5]: 2,
      products[12]: 1,
    },
    createdAt: DateTime(2024, 2, 3, 14, 25),
    updatedAt: DateTime(2024, 2, 6, 9, 50),
  )
];

// Orders
final List<Order> orders = List.generate(
    5,
    (index) => Order(
          orderId: "order_00${index + 1}",
          userId: "user_001",
          latitude: -1.28 + (index * 0.002),
          longitude: 36.82 + (index * 0.003),
          createdAt: DateTime(2024, 1, 20 + index, 18, 30),
          updatedAt: DateTime(2024, 2, 1, 10, 10),
          products: [],
          totalAmount: 0,
          status: Status.values[index % 2],
          payment: index % 2 == 0
              ? {Payment.paypal: "+254720041750"}
              : {Payment.mpesa: "+254720041750"},
        ));

final List<Blog> blogs = [
  Blog(imagePath: "assets/images/phone.png", title: "The Future of Sustainable Farming: Innovations Changing Agriculture", body: "Sustainable farming is becoming increasingly important as the global population grows. Farmers are now adopting precision agriculture, hydroponics, and organic farming to ensure food security while protecting the environment. Precision agriculture, for example, uses sensors and AI to optimize crop yields with minimal resource wastage. As technology advances, the future of farming will be more efficient, eco-friendly, and profitable."),
  Blog(imagePath: "assets/images/bucket.png", title: "Organic Farming: Is It Really Worth the Hype?", body: "Organic farming has gained popularity due to its health benefits and environmental impact. Unlike conventional farming, organic farming avoids synthetic pesticides and fertilizers, leading to healthier food production. However, it comes with challenges like lower yields and higher costs. Farmers and consumers alike must weigh the pros and cons to determine if organic farming is the future of agriculture."),
  Blog(imagePath: "assets/images/shoes.png", title: "Smart Irrigation: How Technology is Revolutionizing Water Management", body: "Water is one of the most critical resources in farming, and smart irrigation systems are helping farmers optimize its use. Drip irrigation, soil moisture sensors, and automated watering systems are reducing water wastage while increasing crop yields. With climate change affecting rainfall patterns, adopting smart irrigation can help farmers sustain their production despite unpredictable weather conditions."),
  Blog(imagePath: "assets/images/laptop.png", title: "The Role of AI and Drones in Modern Agriculture", body: "Artificial intelligence and drone technology are transforming agriculture by improving efficiency and reducing labor costs. Drones are being used to monitor crops, detect diseases, and even spray pesticides with precision. AI-powered tools analyze soil data to provide farmers with insights on when and how to plant crops. These innovations are making farming smarter and more productive."),
  Blog(imagePath: "assets/images/phone.png", title: "Profitable Agribusiness Ideas for Small-Scale Farmers", body: "Agribusiness is not just for large farms; small-scale farmers can also build profitable ventures. Some of the best opportunities include poultry farming, greenhouse vegetable production, beekeeping, and mushroom farming. By focusing on high-demand products and leveraging modern farming techniques, small-scale farmers can increase their income and contribute to food security"),
  Blog(imagePath: "assets/images/phone.png", title: "The Future of Sustainable Farming: Innovations Changing Agriculture", body: "Sustainable farming is becoming increasingly important as the global population grows. Farmers are now adopting precision agriculture, hydroponics, and organic farming to ensure food security while protecting the environment. Precision agriculture, for example, uses sensors and AI to optimize crop yields with minimal resource wastage. As technology advances, the future of farming will be more efficient, eco-friendly, and profitable."),
  Blog(imagePath: "assets/images/bucket.png", title: "Organic Farming: Is It Really Worth the Hype?", body: "Organic farming has gained popularity due to its health benefits and environmental impact. Unlike conventional farming, organic farming avoids synthetic pesticides and fertilizers, leading to healthier food production. However, it comes with challenges like lower yields and higher costs. Farmers and consumers alike must weigh the pros and cons to determine if organic farming is the future of agriculture."),
  Blog(imagePath: "assets/images/shoes.png", title: "Smart Irrigation: How Technology is Revolutionizing Water Management", body: "Water is one of the most critical resources in farming, and smart irrigation systems are helping farmers optimize its use. Drip irrigation, soil moisture sensors, and automated watering systems are reducing water wastage while increasing crop yields. With climate change affecting rainfall patterns, adopting smart irrigation can help farmers sustain their production despite unpredictable weather conditions."),
  Blog(imagePath: "assets/images/laptop.png", title: "The Role of AI and Drones in Modern Agriculture", body: "Artificial intelligence and drone technology are transforming agriculture by improving efficiency and reducing labor costs. Drones are being used to monitor crops, detect diseases, and even spray pesticides with precision. AI-powered tools analyze soil data to provide farmers with insights on when and how to plant crops. These innovations are making farming smarter and more productive."),
  Blog(imagePath: "assets/images/phone.png", title: "Profitable Agribusiness Ideas for Small-Scale Farmers", body: "Agribusiness is not just for large farms; small-scale farmers can also build profitable ventures. Some of the best opportunities include poultry farming, greenhouse vegetable production, beekeeping, and mushroom farming. By focusing on high-demand products and leveraging modern farming techniques, small-scale farmers can increase their income and contribute to food security"),
];
