import 'dart:convert';

import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/data/models.dart';
import 'package:kilimboga/data/constants.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HospitalProvider with ChangeNotifier {
  List<Hospital> _hospitals = [];
  List<Nurse> _nurses = [];

  bool _isLoading = false;
  Hospital? _currentHospital;

  bool get isLoading => _isLoading;

  List<Hospital> get hospitals => _hospitals;
  List<Nurse> get nurses => _nurses;
  Hospital? get currentHospital => _currentHospital;

  HospitalProvider() {
    fetchHospitals();
  }

  Future<int> fetchHospitals() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/hospitals"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
      );
      final data = jsonDecode(response.body);

      _hospitals = data
          .map<Hospital>((hospital) => Hospital(
              name: hospital['name'],
              id: hospital['id'],
              distance: hospital['distance'],
              level: hospital['level']))
          .toList();

      notifyListeners();
      _isLoading = false;
      notifyListeners();
      return response.statusCode;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 500;
    }
  }

  void fetchSingleHospital(String hospitalId) async {
    _isLoading = true;
    _nurses = [];
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/hospitals/$hospitalId"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
      );
      final data = jsonDecode(response.body);
      debugPrint(data.toString());

      _nurses = (data as List)
          .map((nurse) => Nurse(
              name: nurse['full_name'],
              id: nurse['id'],
              phone: nurse['phone'],
              email: nurse['email'],
              speciality: nurse['specialty'],
              fcm: nurse['fcm']))
          .toList();

      debugPrint(_nurses.toString());
      notifyListeners();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
