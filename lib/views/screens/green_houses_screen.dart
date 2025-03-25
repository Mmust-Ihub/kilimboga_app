import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/single_green_house_page.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class GreenHousesScreen extends StatelessWidget {
  const GreenHousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
      builder:
          (BuildContext context, AppointmentProvider provider, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Green Houses',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Text("Add"))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    LazyLoadScrollView(
                      scrollDirection: Axis.horizontal,
                      onEndOfPage: () {
                        debugPrint("End of page");
                      },
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SingleGreenHousePage()));
                              },
                              title: const Text("Grren House Name"),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1)),
                          itemCount: provider.isLoading ? 1 : 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
