import 'package:flutter/material.dart';
import 'package:kilimboga/data/constants.dart';
import 'package:kilimboga/provider/product_provider.dart';
import 'package:provider/provider.dart';

class OrderCheckoutComponent extends StatefulWidget {

  const OrderCheckoutComponent({super.key});

  @override
  State<OrderCheckoutComponent> createState() => _OrderCheckoutComponentState();
}

class _OrderCheckoutComponentState extends State<OrderCheckoutComponent> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: Consumer<ProductProvider>(
          builder: (BuildContext context, ProductProvider productProvider,
              Widget? child) {
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub-Total",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            productProvider.amount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery charge",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            productProvider.transport.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Discount",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            productProvider.discount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            productProvider.totalamount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                        const Size(double.infinity, 40)),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text("Confirm Order",
                      style: TextStyle(color: primaryColor)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
