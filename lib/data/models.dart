import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  final String id;
  final String name;
  final double distance;
  final int level;
  Hospital({
    required this.id,
    required this.name,
    required this.distance,
    required this.level,
  });
}

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String id;
  final String? token;

  User(
      {required this.username,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role,
      required this.id,
      required this.token});
}

class Preuser {
  final String email;
  final String password;

  Preuser({
    required this.email,
    required this.password,
  });
}

class Appointment {
  final String id;
  final String nurse;
  final String date;
  final String time;
  final String status;
  final String reason;

  Appointment({
    required this.id,
    required this.nurse,
    required this.date,
    required this.status,
    required this.time,
    required this.reason,
  });
}

class Nurse {
  final String id;
  final String email;
  final String? phone;
  final String name;
  final List speciality;
  final List fcm;

  Nurse(
      {required this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.fcm,
      required this.speciality});
}

class Message {
  final String receiverId;
  final String message;

  Message({required this.receiverId, required this.message});

  Map<String, dynamic> toMap() {
    return {
      "recieverid": receiverId,
      "message": message,
    };
  }
}

class DisplayMessage {
  final String senderid;
  final String message;

  DisplayMessage({required this.senderid, required this.message});
}

class ChatRoom {
  final String id;
  final List<String> participants;
  final String? lastMessage;

  ChatRoom({required this.id, required this.participants, this.lastMessage});

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      participants: List<String>.from(data['participants']),
      lastMessage: data['lastMessage'],
    );
  }

  String getOtherParticipant(String userId) {
    return participants.firstWhere((id) => id != userId,
        orElse: () => "Unknown");
  }
}

class SmartDevice {
  final String name;
  final String icon;
  bool powerStatus;

  SmartDevice(
      {required this.name, required this.icon, required this.powerStatus});
}

class SensorData {
  SensorData(this.time, this.nitrogen, this.phosphorus, this.potassium, this.moisture, this.humidity, this.temperature, this.ph);
  final DateTime time;
  final double nitrogen, phosphorus, potassium, moisture, humidity, temperature, ph;
}
