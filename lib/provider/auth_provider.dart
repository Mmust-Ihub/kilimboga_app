import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/services/geo_locator_service.dart';
import 'package:kilimboga/services/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:kilimboga/data/constants.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String _message = "Authenticating";

  bool get isLoading => _isLoading;
  String get message => _message;

  Position? position;

  AuthProvider() {
    getUserPosition();
  }

  void getUserPosition() async {
    position = await LocationService.determinePosition();
  }

  Future<int> authUser(String email, String password) async {
    _message = "Verifying account";

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = User(
            username: data['user']['username'],
            email: data['user']['email'],
            role: data['user']['role'],
            id: data['user']['id'],
            token: data['token'],
            firstName: data['user']['firstName'],
            lastName: data['user']['lastName']);

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
        _message = "updating location";
        notifyListeners();

        if (position != null) {
          await http.patch(
            Uri.parse("$baseUrl/user/location"),
            headers: {
              "Content-Type": "application/json",
              'Authorization': "Bearer ${user!.token!}",
            },
            body: jsonEncode({
              "latitude": position!.latitude,
              "longitude": position!.longitude,
            }),
          );
        }
        updateFcm();
      }

      _isLoading = false;
      notifyListeners();
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());

      _isLoading = false;
      notifyListeners();
      return 500;
    }
  }

  Future<int> createUser(String email, String username, String password) async {
    _isLoading = true;
    _message = "creating account";

    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
          "email": email,
        }),
      );

      if (response.statusCode == 201) {
        preuser = Preuser(email: email, password: password);

        setPreUserToPrefs();
      }

      _isLoading = false;
      notifyListeners();
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());

      _isLoading = false;
      notifyListeners();
      return 500;
    }
  }

  Future<int> validateToken(String email, String code, String password) async {
    _isLoading = true;
    _message = "validating ";

    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/validate-code"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "code": code,
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        await authUser(email, password);
      }

      _isLoading = false;
      notifyListeners();
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());

      _isLoading = false;
      notifyListeners();
      return 500;
    }
  }

  Future<void> updateFcm() async {
    _message = "updating fcm";

    _isLoading = true;
    notifyListeners();
    try {
      await http.post(
        Uri.parse("$baseUrl/user/fcm"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
        body: jsonEncode({
          "fcm": fcm,
        }),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());

      _isLoading = false;
      notifyListeners();
    }
  }
}
