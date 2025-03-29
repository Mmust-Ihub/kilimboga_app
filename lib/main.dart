import 'package:flutter/material.dart';
import 'package:kilimboga/config/size_config.dart';
import 'package:kilimboga/provider/appointment_provider.dart';
import 'package:kilimboga/provider/auth_provider.dart';
import 'package:kilimboga/provider/cart_provider.dart';
import 'package:kilimboga/provider/hospital_provider.dart';
import 'package:kilimboga/provider/messaging_provider.dart';
import 'package:kilimboga/provider/product_provider.dart';
import 'package:kilimboga/provider/theme_provider.dart';
import 'package:kilimboga/views/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MessagingProvider()),
        ChangeNotifierProvider(create: (_) => HospitalProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kilimboga',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LoginPage(),
    );
  }
}
