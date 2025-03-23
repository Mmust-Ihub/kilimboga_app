import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/layout/patient/appointments_screen.dart';
import 'package:kilimboga/layout/patient/chat_screen.dart';
import 'package:kilimboga/layout/patient/components/appointment_card.dart';
import 'package:kilimboga/layout/patient/profile_screen.dart';
import 'package:kilimboga/layout/patient/single_hospital.dart';
import 'package:kilimboga/models/models.dart';
import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:flutter/material.dart';

import 'package:kilimboga/provider/hospital_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer2<HospitalProvider, AppointmentProvider>(
            builder: (BuildContext context, HospitalProvider provider,
                AppointmentProvider value, Widget? child) {
              List<Appointment> appointments =
                  value.appointments.take(5).toList();

              return Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${user!.firstName}',
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
                            'How are you feeling today?',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              provider.fetchHospitals();
                            },
                            child: Text(
                              'Nearest Hospitals',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: provider.isLoading
                                ? Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  )
                                : provider.hospitals.isEmpty
                                    ? Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: const Center(
                                          child: Text("No hospitals around"),
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: provider.hospitals.length,
                                        itemBuilder: (context, index) {
                                          final hospital =
                                              provider.hospitals[index];

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return SingleHospital(
                                                    hospital: hospital,
                                                  );
                                                }),
                                              );
                                            },
                                            child: Container(
                                              width: 200,
                                              margin: const EdgeInsets.only(
                                                  right: 16),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: isDark
                                                    ? const Color(0xFF374151)
                                                    : Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .local_hospital_outlined,
                                                          size: 56,
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                        Text(
                                                          hospital.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: isDark
                                                                ? const Color(
                                                                    0xFFF3F4F6)
                                                                : const Color(
                                                                    0xFF1F2937),
                                                          ),
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Level: ${hospital.level}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: isDark
                                                                      ? const Color(
                                                                          0xFF9CA3AF)
                                                                      : const Color(
                                                                          0xFF6B7280),
                                                                ),
                                                              ),
                                                              Text(
                                                                '${hospital.distance.toStringAsFixed(2)} km',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: isDark
                                                                      ? const Color(
                                                                          0xFF9CA3AF)
                                                                      : const Color(
                                                                          0xFF6B7280),
                                                                ),
                                                              ),
                                                            ]),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    return value.isLoading
                                                        ? const SizedBox()
                                                        : AppointmentCard(
                                                            appointment:
                                                                appointments[
                                                                    index],
                                                          );
                                                  },
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      Divider(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.1)),
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
        ),
      ),
    );
  }
}

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const AppointmentsScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      body: _screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          elevation: 2.0,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    icon: const Icon(Icons.home_outlined)),
                label: "Home"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Icons.schedule_outlined)),
                label: "Appointments"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    icon: const Icon(Icons.comment_rounded)),
                label: "Messages"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    icon: const Icon(Icons.person)),
                label: "Profile"),
          ]),
    );
  }
}
