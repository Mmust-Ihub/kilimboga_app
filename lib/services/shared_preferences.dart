import 'dart:convert';

import 'package:kilimboga/components/login_page.dart';
import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> initSharedPreference() async {
  prefs = await SharedPreferences.getInstance();
}

Future<User?> getUserFromPrefs() async {
  String? userData = prefs!.getString('userData');

  if (userData != null) {
    Map<String, dynamic> userMap = jsonDecode(userData);
    return User(
      username: userMap['username'],
      email: userMap['email'],
      role: userMap['role'],
      id: userMap['id'],
      token: userMap['token'],
      firstName: userMap['firstName'],
      lastName: userMap['lastName'],
    );
  }
  return null;
}

Future<void> setUserToPrefs() async {
  debugPrint(user.toString());
  await prefs!.setString(
      'userData',
      jsonEncode({
        "username": user!.username,
        "email": user!.email,
        "role": user!.role,
        "id": user!.id,
        "token": user!.token,
        "firstName": user!.firstName,
        "lastName": user!.lastName,
      }));
}

Future<Preuser?> getPreUserFromPrefs() async {
  String? preuser = prefs!.getString('preuser');

  if (preuser != null) {
    Map<String, dynamic> userMap = jsonDecode(preuser);
    return Preuser(
      email: userMap['email'],
      password: userMap['password'],
    );
  }
  return null;
}

Future<void> setPreUserToPrefs() async {
  await prefs!.setString(
      'preuser',
      jsonEncode({
        "email": preuser!.email,
        "password": preuser!.password,
      }));
}

Future<String?> getUserFcm() async {
  String? fcm = prefs!.getString('fcm');

  return fcm;
}

Future<void> logoutUser(BuildContext context) async {
  await prefs!.remove('userData');
  user = null;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
