import 'package:iconsax/iconsax.dart';
import 'package:kilimboga/components/appointment_card.dart';
import 'package:kilimboga/components/dashboard_stat.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';

import 'package:kilimboga/provider/hospital_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer2<HospitalProvider, AppointmentProvider>(
        builder: (BuildContext context, HospitalProvider provider,
            AppointmentProvider value, Widget? child) {
          List<Appointment> appointments = value.appointments.take(5).toList();

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Wa Kirigu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? const Color(0xFFF3F4F6)
                              : const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lets manage your farms',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const DashboardStat(
                                name: "Green Houses",
                                icon: Iconsax.tree,
                                color: Colors.greenAccent,
                                value: "3"),
                            DashboardStat(
                                name: "Devices",
                                icon: Iconsax.devices,
                                color: Colors.grey.shade700,
                                value: "12"),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DashboardStat(
                                name: "Temperature",
                                icon: Iconsax.cloud_sunny,
                                color: Colors.orangeAccent,
                                value: "39.2"),
                            DashboardStat(
                                name: "Humidity",
                                icon: Iconsax.cloud_drizzle,
                                color: Colors.blueAccent,
                                value: "12.1"),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      if (value.appointments.isNotEmpty)
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Upcoming appointments",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    if (value.appointments.length > 5)
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "View all",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              value.isLoading
                                  ? Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                    )
                                  : value.appointments.isEmpty
                                      ? Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: Colors.grey.shade100,
                                          child: const Center(
                                              child: Text(
                                                  "No scheduled appointments")))
                                      : Wrap(
                                          children: [
                                            ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return value.isLoading
                                                      ? const SizedBox()
                                                      : AppointmentCard(
                                                          appointment:
                                                              appointments[
                                                                  index],
                                                        );
                                                },
                                                separatorBuilder:
                                                    (context, index) => Divider(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.1)),
                                                itemCount: value.isLoading
                                                    ? 1
                                                    : appointments.length),
                                          ],
                                        ),
                            ])
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
