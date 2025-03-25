import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

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
              child: Text(
                'Green Houses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text("Grren House Name"),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1)),
                    itemCount: provider.isLoading ? 1 : 20),
              ],
            ),
          ],
        );
      },
    );
  }
}
