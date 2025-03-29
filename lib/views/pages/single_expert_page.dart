// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimboga/components/testimonial_card.dart';

class SingleExpertPage extends StatefulWidget {
  const SingleExpertPage({super.key});

  @override
  State<SingleExpertPage> createState() => _SingleExpertPageState();
}

class _SingleExpertPageState extends State<SingleExpertPage> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(children: [
          AspectRatio(
            aspectRatio: 9 / 12,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/doctor.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            key: _sheet,
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            expand: true,
            controller: _controller,
            builder: (BuildContext context, ScrollController scrollController) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    controller: scrollController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_half_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                          size: 20,
                                        ),
                                        Text(
                                          "4.2",
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 100,
                                    height: 20,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                          size: 20,
                                        ),
                                        Text(
                                          "12 m",
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Iconsax.message,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.5),
                                      size: 20,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Iconsax.call,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.5),
                                      size: 20,
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            "Expert's Biography",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Testimonials'),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.all(0.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
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
                                    ? 'Great services'
                                    : "Amazing person and expert",
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 10),
                            itemCount: 5,
                          )
                        ]),
                  ),
                ),
              );
            },
          )
        ]);
      }),
    );
  }
}
