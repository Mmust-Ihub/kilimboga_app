import 'package:flutter/material.dart';
import 'package:kilimboga/components/order_checkout_component.dart';
import 'package:kilimboga/components/order_item.dart';
import 'package:kilimboga/data/product.dart';
import 'package:kilimboga/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_left_sharp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.8),
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
                    child: Consumer<ProductProvider>(
                      builder: (BuildContext context,
                          ProductProvider productprovider, Widget? child) {
                        final Map<Product, int> cartproducts =
                            productprovider.cartproducts;

                        return Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  final productEntry =
                                      cartproducts.entries.elementAt(index);
                                  final Product product = productEntry.key;
                                  final int quantity = productEntry.value;
                                  return OrderItem(
                                    quantityItem: quantity,
                                    productItem: product,
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
                            const OrderCheckoutComponent(),
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
    );
  }
}
