import 'package:flutter/material.dart';
import 'package:kilimboga/views/screens/home_screen.dart';
import 'package:kilimboga/views/screens/profile_screen.dart';
import 'package:kilimboga/views/screens/appointments_screen.dart';
import 'package:kilimboga/views/screens/chat_screen.dart';


class Farmer extends StatefulWidget {
  const Farmer({super.key});

  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {

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
