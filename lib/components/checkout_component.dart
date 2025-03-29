import 'package:flutter/material.dart';
import 'package:kilimboga/data/constants.dart';
import 'package:kilimboga/provider/cart_provider.dart';

class CheckoutComponent extends StatefulWidget {
  final CartProvider cartProvider;
  const CheckoutComponent({super.key, required this.cartProvider});

  @override
  State<CheckoutComponent> createState() => _CheckoutComponentState();
}

class _CheckoutComponentState extends State<CheckoutComponent> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = widget.cartProvider;
    return Container(
      padding: const EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: AssetImage('assets/images/pattern2.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(130, 21, 190, 120),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Stack(
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
                                  cart.amount.toString(),
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
                                  cart.transport.toString(),
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
                                  cart.discount.toString(),
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
                                  cart.totalamount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      alignment: const Alignment(0, 1),
                      child: FilledButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                              const Size(double.infinity, 40)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text("Order Now",
                            style: TextStyle(color: primaryColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
