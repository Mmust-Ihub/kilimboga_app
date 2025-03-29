import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/single_product_page.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productPrice;
  const ProductCard(
      {super.key,
      required this.imagePath,
      required this.productName,
      required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const SingleProductPage(productId: "prod_002")));
      },
      splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                height: 182,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              productName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
            Text(
              productPrice,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
