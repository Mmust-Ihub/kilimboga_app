import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kilimboga/components/cart_item.dart';
import 'package:kilimboga/components/checkout_component.dart';
import 'package:kilimboga/data/product.dart';
import 'package:kilimboga/provider/cart_provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Cart Items',
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
                  builder: (BuildContext context, CartProvider cartProvider,
                      Widget? child) {
                    final Map<Product, int> cartproducts =
                        cartProvider.cartproducts;
                    return Column(
                      children: [
                        Expanded(
                          child: LazyLoadScrollView(
                            onEndOfPage: () {},
                            child: SlidableAutoCloseBehavior(
                              closeWhenOpened: true,
                              closeWhenTapped: true,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final productEntry =
                                      cartproducts.entries.elementAt(index);
                                  final Product product = productEntry.key;
                                  final int quantity = productEntry.value;
                                  return CartItem(
                                    productItem: product,
                                    quantityItem: quantity,
                                    cartprovider: cartProvider,
                                  );
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
                        const CheckoutComponent(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
