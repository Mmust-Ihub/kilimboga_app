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
      body:Center(child:Text("Chat_page_placeholder"),),
    ),
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FarmerAppDrawer(scaffoldKey: scaffoldKey),
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
                    icon: const Icon(Iconsax.home)),
                label: "Home"),
            NavigationDestination(
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Icons.schedule_outlined)),
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
