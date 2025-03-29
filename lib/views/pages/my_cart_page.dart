import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kilimboga/components/cart_item.dart';
import 'package:kilimboga/components/checkout_component.dart';
import 'package:kilimboga/data/product.dart';
import 'package:kilimboga/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/pattern2.webp'),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade100,
                Colors.white,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(17, 218, 98, 23),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_left_sharp,
                                color: Color(0xFFDA6317),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          'Order details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Consumer<CartProvider>(
                        builder: (BuildContext context, CartProvider cart,
                            Widget? child) {
                          final cartProvider = context.read<CartProvider>();
                          final Map<Product, int> cartproducts =
                              cart.cartproducts;
                          return Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: SlidableAutoCloseBehavior(
                                    closeWhenOpened: true,
                                    closeWhenTapped: true,
                                    child: ListView.separated(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final productEntry = cartproducts
                                            .entries
                                            .elementAt(index);
                                        final Product product =
                                            productEntry.key;
                                        final int quantity = productEntry.value;
                                        return CartItem(productItem: product,quantityItem: quantity, cartprovider: cartProvider,);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        height: 5,
                                      ),
                                      itemCount: cartproducts.length,
                                    ),
                                  ),
                                ),
                              ),
                              CheckoutComponent(cartProvider: cart,)
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
