import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const Row(
          children: [
            Text(
              " My Orders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10,),
        Expanded(
          child: LazyLoadScrollView(
            onEndOfPage: () {},
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        "assets/images/shoes.png",
                      ),
                      title: Text(
                        "Product Name",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        "2,100",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(
                        Iconsax.tick_circle,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7),
                        size: 20,
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(
                      thickness: 0.7,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
                itemCount: 20),
          ),
        ),
      ]),
    );
  }
}
