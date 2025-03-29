import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimboga/components/product_card.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      focusNode: focusNode,
                      onTapOutside: (_) {
                        focusNode.unfocus();
                      },
                      onTap: () {
                        focusNode.attach(context);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.search_normal,
                            size: 18,
                            color: color,
                          ),
                          suffixIcon: Icon(
                            Iconsax.filter,
                            size: 18,
                            color: color,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: color),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                          label: const Text(
                            "Search",
                            style: TextStyle(fontSize: 12),
                          ),
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: LazyLoadScrollView(
            onEndOfPage: () {  },
                      child: ListView.separated(
                        itemCount: 20,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ProductCard(
                          imagePath: index % 2 == 0
                              ? "assets/images/phone.png"
                              : "assets/images/bucket.png",
                          productName: index % 2 == 0 ? 'Laptop' : 'Bucket',
                          productPrice: index % 2 == 0 ? '2,000' : "2,300",
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
