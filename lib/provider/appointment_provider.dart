import 'package:kilimboga/data/dummy_data.dart';
import 'package:kilimboga/models/models.dart';
import 'package:kilimboga/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String _message = "Fetching";

  String get message => _message;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;

  AppointmentProvider() {
    fetchAppointments();
  }

  void fetchAppointments() async {
    _isLoading = true;
    _message = "fetching";
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/appointments/"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
      );
      final data = jsonDecode(response.body);

      _appointments = (data['appointments'] as List)
          .map((appointment) => Appointment(
                id: appointment['_id'],
                nurse: appointment['nurse'],
                date: appointment['date'],
                time: appointment['time'],
                status: appointment['status'],
                reason: appointment['reason'],
              ))
          .toList();

      notifyListeners();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> createAppointment(
      String nurseId, String reason, DateTime date, String time) async {
    _message = "creating...";
    _isLoading = true;
    notifyListeners();
    try {
      debugPrint("Creeating appointment");
      debugPrint(isLoading.toString());

      final response = await http.post(
        Uri.parse("$baseUrl/appointments/"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer ${user!.token!}",
        },
        body: jsonEncode({
          "nurseid": nurseId,
          "reason": reason,
          "date": date.toString(),
          "time": time,
        }),
      );

      _isLoading = false;
      fetchAppointments();
      notifyListeners();
      return response.statusCode;
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return 500;
    }
  }
}
