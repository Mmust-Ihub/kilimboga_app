import 'package:flutter/material.dart';
import 'package:kilimboga/views/screens/my_cart_screen.dart';
import 'package:kilimboga/views/screens/my_orders_screen.dart';

class MyShopPage extends StatefulWidget {
  const MyShopPage({super.key});

  @override
  State<MyShopPage> createState() => _MyShopPageState();
}

class _MyShopPageState extends State<MyShopPage> {
  final List<Widget> _screens = [
    const MyOrdersScreen(),
    const MyCartScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color activeColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.8);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _screens[selectedIndex],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        child: Row(children: [
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: selectedIndex == 0
                      ? activeColor
                      : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  foregroundColor: selectedIndex == 0
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  side: BorderSide(
                    color: selectedIndex == 0
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                        : activeColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: const Text("Orders")),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: selectedIndex == 1
                      ? activeColor
                      : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  foregroundColor: selectedIndex == 1
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  side: BorderSide(
                    color: selectedIndex == 1
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                        : activeColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: const Text("Cart")),
          ),
        ]),
      ),
    );
  }
}
