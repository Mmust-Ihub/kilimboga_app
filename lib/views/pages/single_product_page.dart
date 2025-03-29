import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/components/testimonial_card.dart';
import 'package:kilimboga/components/related_product_card.dart';
import 'package:kilimboga/data/constants.dart';
import 'package:kilimboga/provider/cart_provider.dart';
import 'package:kilimboga/provider/product_provider.dart';
import 'package:kilimboga/views/pages/confirm_order.dart';

import 'package:provider/provider.dart';

class SingleProductPage extends StatefulWidget {
  final String productId;
  const SingleProductPage({super.key, required this.productId});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  int isCarted = 0;
  final bool isOrdered = false;

  final List<String> images = [
    'assets/images/laptop.png',
    'assets/images/bucket.png',
    'assets/images/phone.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Consumer2<ProductProvider, CartProvider>(
          builder: (BuildContext context, ProductProvider productProvider,
              CartProvider cartProvider, Widget? child) {
            final product = productProvider.fetchProduct(widget.productId);
            return Stack(children: [
              AspectRatio(
                aspectRatio: 9 / 12,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CarouselSlider(
                    items: images.map((image) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                key: _sheet,
                initialChildSize: 0.5,
                maxChildSize: 0.5,
                minChildSize: 0.5,
                expand: true,
                controller: _controller,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 50),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 20,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star_half_outlined,
                                              color: primaryColor,
                                              size: 16,
                                            ),
                                            Text(
                                              product.ratings.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 80,
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Ksh",
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              product.price.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(height: 15),
                              AspectRatio(
                                aspectRatio: 16 / 2,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    product.description,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Related Products'),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "View more",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                150, 218, 98, 23),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                height: 175,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration:
                                    BoxDecoration(color: Colors.grey[40]),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return RelatedProductCard(
                                            imagePath: index % 2 == 0
                                                ? 'assets/images/phone.png'
                                                : 'assets/images/shoes.png',
                                            prosuctPrice: index % 2 == 0
                                                ? "2,300"
                                                : "2,400",
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const SizedBox(width: 10),
                                        itemCount: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                width: double.infinity,
                                child: Text('Testimonials'),
                              ),
                              Column(
                                children: [
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TestimonialCard(
                                        imagePath: index % 2 == 0
                                            ? 'assets/images/doctor.webp'
                                            : 'assets/images/doctor_1.webp',
                                        userName: index % 2 == 0
                                            ? "Dianne Russell"
                                            : "Byrone Kingsly",
                                        date: index % 2 == 0
                                            ? "23 March 2025"
                                            : "12 April 2021",
                                        review: index % 2 == 0 ? '4' : '5',
                                        comment: index % 2 == 0
                                            ? 'This is so great.So delicious,You must here with your family'
                                            : "What an amazing meals and great experience overall",
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 1),
                                    itemCount: 5,
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: double.infinity,
                alignment: const Alignment(0, 1),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  productProvider.quantity > 1
                                      ? productProvider.quantity -= 1
                                      : productProvider.quantity = 1;
                                });
                              },
                              child: Icon(Icons.remove,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8)),
                            ),
                            Text(productProvider.quantity.toString()),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  productProvider.quantity += 1;
                                });
                              },
                              child: Icon(Icons.add,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: () {
                                    productProvider.addToCart(
                                        product, productProvider.quantity);

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ConfirmOrder(),
                                    ));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.8)),
                                  ),
                                  child: const Text(
                                    "Order Now",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      isCarted = cartProvider.addToCart(
                                          product, productProvider.quantity);

                                      // if (isCarted == 200) {
                                      //   DelightToastBar(
                                      //     snackbarDuration: const Duration(
                                      //         milliseconds: 2000),
                                      //     position: DelightSnackbarPosition.top,
                                      //     autoDismiss: true,
                                      //     builder: (context) => ToastCard(
                                      //       color: primaryColor,
                                      //       leading: Icon(
                                      //           Icons.shopping_cart_outlined,
                                      //           size: 28,
                                      //           color: Colors.white),
                                      //       title: Text(
                                      //         "Item added to cart",
                                      //         style: TextStyle(
                                      //             fontWeight: FontWeight.w700,
                                      //             fontSize: 14,
                                      //             color: Colors.white),
                                      //       ),
                                      //     ),
                                      //   ).show(context);
                                      // } else {
                                      //   DelightToastBar(
                                      //     snackbarDuration: const Duration(
                                      //         milliseconds: 2000),
                                      //     position: DelightSnackbarPosition.top,
                                      //     autoDismiss: true,
                                      //     builder: (context) => ToastCard(
                                      //       color: Colors.red[500],
                                      //       leading: Icon(
                                      //           Icons.shopping_cart_outlined,
                                      //           size: 28,
                                      //           color: Colors.white),
                                      //       title: Text(
                                      //         "Item already exists",
                                      //         style: TextStyle(
                                      //             fontWeight: FontWeight.w700,
                                      //             fontSize: 14,
                                      //             color: Colors.white),
                                      //       ),
                                      //     ),
                                      //   ).show(context);
                                      // }
                                    });
                                  },
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all<BorderSide>(
                                      BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.8),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          },
        );
      }),
    );
  }
}
