import 'package:kilimboga/layout/patient/components/appointment_card.dart';
import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<AppointmentProvider>(
            builder: (BuildContext context, AppointmentProvider provider,
                Widget? child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointments',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? const Color(0xFFF3F4F6)
                              : const Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: provider.appointments.isEmpty
                        ? Container(
                            width: double.infinity,
                            color: Colors.grey.shade100,
                            child: const Center(
                              child: Text("No scheduled appointments"),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Wrap(
                              children: [
                                ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return provider.isLoading
                                          ? const SizedBox()
                                          : AppointmentCard(
                                              appointment:
                                                  provider.appointments[index],
                                            );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1)),
                                    itemCount: provider.isLoading
                                        ? 1
                                        : provider.appointments.length),
                              ],
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
