import 'package:flutter/material.dart';
import 'package:kilimboga/data/product.dart';
import 'package:kilimboga/provider/product_provider.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatefulWidget {
  final int quantityItem;
  final Product productItem;
  const OrderItem(
      {super.key,
      required this.quantityItem,
      required this.productItem,
     });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    final Product product = widget.productItem;
    final int quantity = widget.quantityItem;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider productProvider,
            Widget? child) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0),
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
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              productProvider
                                  .decrement(MapEntry(product, quantity));
                            },
                            child: Icon(Icons.remove,
                                size: 16, color: Colors.green[300]),
                          ),
                          Text(quantity.toString()),
                          GestureDetector(
                            onTap: () {
                              productProvider
                                  .increment(MapEntry(product, quantity));
                            },
                            child: Icon(Icons.add,
                                size: 16, color: Colors.green[300]),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          );
        },
      ),
    );
  }
}
