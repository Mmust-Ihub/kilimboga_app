import 'package:flutter/material.dart';

class ProductTestimonialCard extends StatelessWidget {
  final String imagePath;
  final String userName;
  final String date;
  final String review;
  final String comment;
  const ProductTestimonialCard(
      {super.key,
      required this.imagePath,
      required this.userName,
      required this.date,
      required this.review,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(22.0),

    
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            ),
                            Text(
                              review,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    comment,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 12, overflow: TextOverflow.ellipsis),
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
