// // ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:flutter/services.dart';
// import 'package:kilimboga/services/geo_locator_service.dart';
// import 'package:kilimboga/temporary/models/models.dart';

// class EmergencyService {
//   static Future<void> sendEmergencyEmail({
//     required String userEmail,
//     required String userName,
//     Hospital? hospital,
//   }) async {
//     final smtpServer = gmail('kinslybyrone17@gmail.com', 'qgup bauw pocb fmjw');

//     String _output = 'Not traceable';

  
  

//     Position? position = await Geolocator.getLastKnownPosition();

//     await  placemarkFromCoordinates(position!.latitude,position.longitude)
//                       .then((placemarks) {
//                     var output = 'Couldn"t trace';
//                     if (placemarks.isNotEmpty) {
//                       output = placemarks[0].toString();

                      
//                       _output = output;
                    
//   }});



//     final message = Message()
//       ..from = const Address('medicare@gmail.com', 'MediCare')
//       ..recipients.add('kinslybyrone17@gmail.com')
//       ..subject = 'EMERGENCY: Patient Requires Immediate Assistance'
//       ..html = '''
//         <h2>Emergency Alert</h2>
//         <p>Patient $userName requires immediate medical attention.</p>
//         <p>Possible location $_output. Geolocation ${position.toString()}</p>
//         <p>Contact Information: $userEmail</p>
//       ''';

//     try {
//       await send(message, smtpServer);
//     } catch (e) {
//       debugPrint('Error sending emergency email: $e');
//       rethrow;
//     }
//   }
// }

// // lib/services/power_button_detector.dart

// class PowerButtonDetector {
//   static const platform = MethodChannel('com.medicare/power_button');
//   static const int REQUIRED_PRESSES = 4;
//   static const int PRESS_TIMEOUT = 2000; // milliseconds

//   List<DateTime> _pressTimestamps = [];

//   Future<void> initialize() async {
//     platform.setMethodCallHandler((call) async {
//       if (call.method == 'onPowerButtonPress') {
//         _handlePowerButtonPress();
//       }
//     });
//   }

//   void _handlePowerButtonPress() {
//     final now = DateTime.now();
//     _pressTimestamps.add(now);

//     // Remove old timestamps
//     _pressTimestamps.removeWhere(
//       (timestamp) => now.difference(timestamp).inMilliseconds > PRESS_TIMEOUT,
//     );

//     if (_pressTimestamps.length >= REQUIRED_PRESSES) {
//       _triggerEmergency();
//       _pressTimestamps.clear();
//     }
//   }

//   void _triggerEmergency() {
//     debugPrint("Power button detected");
//     // Trigger emergency email
//     // This would be called from your emergency service
//   }
// }
