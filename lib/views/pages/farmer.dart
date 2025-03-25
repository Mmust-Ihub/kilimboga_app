import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimboga/components/farmer_app_drawer.dart';
import 'package:kilimboga/views/screens/home_screen.dart';
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
    // const ChatScreen(),
    const Scaffold(
      body: Center(
        child: Text("Chat_page_placeholder"),
      ),
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: FarmerAppDrawer(scaffoldKey: _scaffoldKey),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Iconsax.menu),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.user),
                    ),
                  ]),
              Expanded(
                child: _screens[selectedIndex],
              ),
            ],
          ),
        ),
      ),
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
                    icon: const Icon(Iconsax.house)),
                label: "Home"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Iconsax.tree)),
                label: "Farms"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    icon: const Icon(Iconsax.message)),
                label: "Chat"),
          ]),
    );
  }
}
