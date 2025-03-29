import 'package:iconsax/iconsax.dart';
import 'package:kilimboga/config/size_config.dart';
import 'package:kilimboga/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kilimboga/views/pages/blogs_page.dart';
import 'package:kilimboga/views/pages/experts_page.dart';
import 'package:kilimboga/views/pages/market_page.dart';
import 'package:kilimboga/views/pages/my_shop_page.dart';
import 'package:provider/provider.dart';

class FarmerAppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const FarmerAppDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.closeDrawer();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DrawerHeader(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.asset(
                          "assets/images/logo.webp",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatsCard(
                              label: 'Farms',
                              total: 328,
                            ),
                            StatsCard(
                              label: 'Devices',
                              total: 52,
                            ),
                            StatsCard(
                              label: 'Cart',
                              total: 12,
                            ),
                          ]),
                    ]),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.dark_mode_outlined,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8)),
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      fontSize: 16),
                ),
                trailing: CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (_) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  activeColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                ),
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExpertsPage()));
                },
                leading: Icon(Icons.people_outline,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8)),
                title: Text(
                  "Experts",
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      fontSize: 16),
                ),
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BlogsPage()));
                },
                leading: Icon(Iconsax.information,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8)),
                title: Text(
                  "AI Blog",
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      fontSize: 16),
                ),
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MarketPage()));
                },
                leading: Icon(Iconsax.shop,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8)),
                title: Text(
                  "Market",
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      fontSize: 16),
                ),
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyShopPage()));
                },
                leading: Icon(Icons.dark_mode_outlined,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.8)),
                title: Text(
                  "My Shop",
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      fontSize: 16),
                ),
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final int total;
  const StatsCard({
    super.key,
    required this.label,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 20,
      child: Column(children: [
        Text(
          total.toString(),
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              fontSize: 12),
        ),
        Text(
          label,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
              fontSize: 14),
        )
      ]),
    );
  }
}
