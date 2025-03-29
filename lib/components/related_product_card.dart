import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/single_product_page.dart';

class RelatedProductCard extends StatelessWidget {
  final String imagePath;
  final String prosuctPrice;
  const RelatedProductCard(
      {super.key, required this.imagePath, required this.prosuctPrice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const SingleProductPage(productId: "prod_002")));
      },
      splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(imagePath),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                prosuctPrice,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
