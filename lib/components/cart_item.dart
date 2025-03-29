import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kilimboga/data/constants.dart';
import 'package:kilimboga/data/product.dart';
import 'package:kilimboga/provider/cart_provider.dart';

class CartItem extends StatefulWidget {
  final int quantityItem;
  final Product productItem;
  final CartProvider cartprovider;
  const CartItem(
      {super.key,
      required this.quantityItem,
      required this.productItem,
      required this.cartprovider});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final Product product = widget.productItem;
    final int quantity = widget.quantityItem;
    final CartProvider cartProvider = widget.cartprovider;
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
          dismissible: DismissiblePane(onDismissed: () {
            cartProvider.deleteItem(product);
          }),
          motion: const ScrollMotion(),
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.green[50],
              child: IconButton(
                onPressed: () {
                  cartProvider.deleteItem(product);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: primaryColor,
                ),
              ),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    product.logo,
                    height: 50,
                    width: 50,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          product.price.toString(),
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ]),
                                ),
                              ]),
                        ]),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartProvider.decrement(MapEntry(product, quantity));
                          },
                          child: Icon(Icons.remove,
                              size: 16, color: Colors.green[300]),
                        ),
                        Text(quantity.toString()),
                        GestureDetector(
                          onTap: () {
                            cartProvider.increment(MapEntry(product, quantity));
                          },
                          child: Icon(Icons.add,
                              size: 16, color: Colors.green[300]),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
